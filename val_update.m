if exist('traj_frequency','var') == 0
    if strcmp(traj_type, 'lorenz') == 1
        traj_frequency = 100;
    elseif strcmp(traj_type, 'cirlce') == 1
%         traj_frequency = 150;
        traj_frequency = 200;
    else
        traj_frequency = 75;
    end
end

properties = [1,1,0.5,0.5,0.25,0.25,0.03,0.03];
dim_in = 8;
dt = 0.01;
time_infor = struct();
time_infor.section_len = 8000;
time_infor.washup_length = 100200;
time_infor.train_length = 20000500;
time_infor.val_length = 200000;
time_infor.time_length = 20401200;

% no_distur
[control_infor, output_infor] = func_validate(traj_type,bridge_type,properties,dim_in,time_infor,dt,plot_movie,traj_frequency);

% with_distur
% [control_infor, output_infor] = func_validate_with_distur(traj_type,bridge_type,properties,dim_in,time_infor,dt,plot_movie,traj_frequency);
% update
data_pred=output_infor.data_pred;
q_pred=output_infor.q_pred;
qdt_pred=output_infor.qdt_pred;
q2dt_pred=output_infor.q2dt_pred;
tau_pred=output_infor.tau_pred;

q_control=control_infor.q_control;
qdt_control=control_infor.qdt_control;
q2dt_control=control_infor.q2dt_control;
tau_control=control_infor.tau_control;
data_control=control_infor.data_control;

delta_u1 = control_infor.delta_u1;
error = control_infor.error;
delta_error = control_infor.delta_error;


% with_distur
control_infor = struct('q_control', q_control, 'qdt_control', qdt_control, ... 
    'q2dt_control', q2dt_control, 'tau_control', tau_control, 'data_control',data_control,...
    'q_pred', q_pred, 'qdt_pred', qdt_pred, ... 
    'q2dt_pred', q2dt_pred, 'tau_pred', tau_pred, 'data_pred',data_pred,...
    'delta_u1',delta_u1,'error',error,'delta_error',delta_error);
with_infor = control_infor;

% save(['./comparitive_data/01meefnn_lorenz', '.mat'], 'control_infor')
% save(['./comparitive_data/02meefnn_mg30', '.mat'], 'control_infor')
% save(['./comparitive_data/meefnn_data/03meefnn_circle', '.mat'], 'control_infor')
% save(['./comparitive_data/meefnn_data/04meefnn_fermat', '.mat'], 'control_infor')

% no_distur
% no_infor = struct('q_control', q_control, 'qdt_control', qdt_control, ... 
%     'q2dt_control', q2dt_control, 'tau_control', tau_control, 'data_control',data_control,...
%     'q_pred', q_pred, 'qdt_pred', qdt_pred, ... 
%     'q2dt_pred', q2dt_pred, 'tau_pred', tau_pred, 'data_pred',data_pred);

% save(['./with_distur_measure/01_lorenz', '.mat'], 'with_infor')
% save(['./with_distur_measure/02_rossler', '.mat'], 'with_infor')
% save(['./with_distur_measure/03_chua', '.mat'], 'with_infor')
% save(['./with_distur_measure/04_circle', '.mat'], 'with_infor')
% save(['./with_distur_measure/05_astroid', '.mat'], 'with_infor')
% save(['./with_distur_measure/06_epitrochoid', '.mat'], 'with_infor')

% save(['./no_distur_measure/01_lorenz', '.mat'], 'no_infor')
% save(['./no_distur_measure/02_rossler', '.mat'], 'no_infor')
% save(['./no_distur_measure/03_chua', '.mat'], 'no_infor')
% save(['./no_distur_measure/04_circle', '.mat'], 'no_infor')
% save(['./no_distur_measure/05_astroid', '.mat'], 'no_infor')
% save(['./no_distur_measure/06_epitrochoid', '.mat'], 'no_infor')

% save(['./comparitive_data/meefnn_data/06meefnn_infty', '.mat'], 'control_infor')
% save(['./comparitive_data/meefnn_data/07meefnn_astroid', '.mat'], 'control_infor')
% save(['./comparitive_data/meefnn_data/08meefnn_talbot', '.mat'], 'control_infor')

val_length=time_infor.val_length;

start_time=1;
end_time=val_length-100;

if plot_val_and_update==1
    
    figure();
    hold on
    plot(data_control(start_time:end_time, 1), data_control(start_time:end_time, 2),'LineWidth', 2.5);
    plot(data_pred(start_time:end_time, 1), data_pred(start_time:end_time, 2),'--','LineWidth', 2.5);
    legend('desired trajectory', 'pred trajectory')
    
    figure();
    hold on
    plot(data_control(start_time:end_time, 1), data_control(start_time:end_time, 2),'Color',[0.5255    0.7137    0.9647],'LineWidth', 2.5);
    xlim([-1, 1])
    ylim([-1, 1])
    legend('trajectory')
end
