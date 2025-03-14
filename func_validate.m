function [control_infor,output_infor] = func_validate(traj_type,bridge_type,properties,dim_in,time_infor,dt,plot_movie,...
    traj_frequency)

[m1, m2, l1, l2, lc1, lc2, I1, I2] = matsplit(properties);

u=zeros(dim_in,1);

val_length=200000;
q_control=zeros(val_length+100, 2);
qdt_control=zeros(val_length+100, 2);
q2dt_control=zeros(val_length+100, 2);
tau_control=zeros(val_length+100, 2);

delta_u1 = zeros(val_length+100, 1);
error = zeros(val_length+100, 1);
delta_error = zeros(val_length+100, 1);

q_control(1, 1) = (6-4)*rand(1) + 4;
q_control(1, 2) = (0.0 - 2.4) * rand(1) - 0.1;

%   judge if there is any nan number:
%   dbstop if naninf
q_pred=q_control;
qdt_pred=qdt_control;
q2dt_pred=q2dt_control;
tau_pred=tau_control;

control_infor = struct('q_control', q_control, 'qdt_control', qdt_control, ... 
    'q2dt_control', q2dt_control, 'tau_control', tau_control,...
    'delta_u1',delta_u1,'error',error,'delta_error',delta_error);

%% generate desired trajectory
[control_infor, time_infor] = func_desired_traj(traj_type, bridge_type, time_infor, control_infor, properties, dt, plot_movie, traj_frequency);

q_control=control_infor.q_control;
qdt_control=control_infor.qdt_control;

%%% 
tau_control = control_infor.tau_control;

val_length=time_infor.val_length;

%x_control,y_control: The Cartesian coordinates of the end effector%
x_control=l1*cos(q_control(:,1))+l2*cos(q_control(:,1)+q_control(:,2));
y_control=l1*sin(q_control(:,1))+l2*sin(q_control(:,1)+q_control(:,2));
data_control=[x_control, y_control];

control_infor.data_control=data_control;

input_infor={'xy', 'qdt'};

%% validation
if length(input_infor)==2 && strcmp(input_infor(1), 'xy') == 1 && strcmp(input_infor(2), 'qdt') == 1
    input_infor_label = 1;
    u(:)=[data_control(1,:)';data_control(2,:)';qdt_control(1,:)';qdt_control(2,:)'];
end

data_pred = data_control;

% generate gaussian noise matrix for noise testing
rng((now*1000-floor(now*1000))*100000)

disturbance_failure = zeros(2, val_length);
measurement_failure = zeros(round(dim_in/2), val_length);

% limit the predicted tau
taudt_threshold = [-5e-2, 5e-2];

% In each step, according to the predicted value, the system evolves
% according to its inherent rule.

load('./IT2FCM-Offline/tao2_weight/tao2_G.mat');
load('./IT2FCM-Offline/tao2_weight/tao2_vl.mat');
load('./IT2FCM-Offline/tao2_weight/tao2_vr.mat');

delta_u = 0;
u_c = 0;
for t_i = 1:val_length-3
    train_x = u';  
    data2 = train_x(:,:);
    
    tao_2 = compute_tao(vl2,vr2,data2,G2); 

    tao_2 = tao_2 + delta_u * tao_2; 

    tao_2 = tao_2 + u_c;
    predict_value = tao_2';

    disturbance_f_value = predict_value .* disturbance_failure(:, t_i);
    predict_value = predict_value + disturbance_f_value;
    
    if t_i == 1
        time_li = 1;
    else
        time_li = t_i - 1;
    end
    for li = 1:2
        if predict_value(li) - tau_pred(time_li, li) > taudt_threshold(2)*dt
            predict_value(li) = tau_pred(time_li, li) + taudt_threshold(2)*dt;
        end
        if predict_value(li) - tau_pred(time_li, li) < taudt_threshold(1)*dt
            predict_value(li) = tau_pred(time_li, li) + taudt_threshold(1)*dt;
        end
    end
    tau_pred(t_i, :) = predict_value;
    
    time_now=t_i;

    H11=m1*lc1^2+I1+m2*(l1^2+lc2^2+2*l1*lc2*cos(q_pred(time_now,2)))+I2;
    H12=m2*l1*lc2*cos(q_pred(time_now,2))+m2*lc2^2+I2;

    H21=H12;
    H22=m2*lc2^2+I2;
    h=m2*l1*lc2*sin(q_pred(time_now,2));

    part_1=-h*qdt_pred(time_now,2)*qdt_pred(time_now,1)-h*(qdt_pred(time_now,1)+qdt_pred(time_now,2))*qdt_pred(time_now,2);
    part_2=h*qdt_pred(time_now,1)*qdt_pred(time_now,1);
    denominator=H12*H21-H11*H22;

    q2dt_pred(time_now,1)=-(-part_1*H22+H12*part_2-H12*predict_value(2)+H22*predict_value(1))/denominator;
    q2dt_pred(time_now,2)=-(part_1*H21-H11*part_2+H11*predict_value(2)-H21*predict_value(1))/denominator;

    q_pred(time_now+1,:)=q_pred(time_now,:)+qdt_pred(time_now,:)*dt;
    qdt_pred(time_now+1,:)=qdt_pred(time_now,:)+q2dt_pred(time_now,:)*dt;

    x_pred=l1*cos(q_pred(time_now+1,1))+l2*cos(q_pred(time_now+1,1)+q_pred(time_now+1,2));
    y_pred=l1*sin(q_pred(time_now+1,1))+l2*sin(q_pred(time_now+1,1)+q_pred(time_now+1,2));
    
    x_measurement_f_value = x_pred .* measurement_failure(1, t_i);
    y_measurement_f_value = y_pred .* measurement_failure(2, t_i);
    qdt_measurement_f_value = qdt_pred(time_now+1, :) .* measurement_failure(3:4, t_i)';

    x_pred_measurement = x_pred + x_measurement_f_value;
    y_pred_measurement = y_pred + y_measurement_f_value;
    qdt_pred_measurement = qdt_pred(time_now+1, :) + qdt_measurement_f_value;

    data_pred(time_now+1,:)=[x_pred, y_pred];

    if input_infor_label == 1
        u(1:2) = [x_pred_measurement;y_pred_measurement]; % Cartesian coordinates of the end effector
        u(3:4) = data_control(time_now+2,:);  % The Cartesian coordinates of the end effector%
        u(5:6) = qdt_pred_measurement;        % dot q
        u(7:8) = qdt_control(time_now+2,:);   
        y = u';
    end
    [delta_u,e,edt] = adjustment(train_x,y); 
    delta_u1(time_now,:) = delta_u;
    error(time_now,:) = e;
    delta_error(time_now,:) = edt;
    u_c = compensation(train_x,y);
end

%% output

output_infor.data_pred = data_pred;
output_infor.q_pred = q_pred;
output_infor.qdt_pred = qdt_pred;
output_infor.q2dt_pred = q2dt_pred;
output_infor.tau_pred = tau_pred;

end