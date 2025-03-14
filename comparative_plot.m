clc
clear
close all

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

% load('./no_distur_measure/01_lorenz.mat')
% load('./rc_data/01_lorenz.mat')

% load('./no_distur_measure/02_rossler.mat')
% load('./rc_data/02_rossler.mat')

load('./no_distur_measure/03_chua.mat')
load('./rc_data/03_chua.mat')

% load('./no_distur_measure/04_circle.mat')
% load('./rc_data/04_circle.mat')

% load('./no_distur_measure/05_astroid.mat')
% load('./rc_data/05_astroid.mat')

% load('./no_distur_measure/06_epitrochoid.mat')
% load('./rc_data/06_epitrochoid.mat')

start_time=1;
end_time=200100-100;
control_infor = no_infor;

data_pred=control_infor.data_pred;
q_pred=control_infor.q_pred;
qdt_pred=control_infor.qdt_pred;
q2dt_pred=control_infor.q2dt_pred;
tau_pred=control_infor.tau_pred;

q_control=control_infor.q_control;
qdt_control=control_infor.qdt_control;
q2dt_control=control_infor.q2dt_control;
tau_control=control_infor.tau_control;
data_control=control_infor.data_control;

data_predrc=rc_infor.data_pred;
q_predrc=rc_infor.q_pred;
qdt_predrc=rc_infor.qdt_pred;
q2dt_predrc=rc_infor.q2dt_pred;
tau_predrc=rc_infor.tau_pred;

q_controlrc=rc_infor.q_control;
qdt_controlrc=rc_infor.qdt_control;
q2dt_controlrc=rc_infor.q2dt_control;
tau_controlrc=rc_infor.tau_control;
data_controlrc=rc_infor.data_control;

% reference trajectory 
figure();
hold on
% plot(data_control(start_time:end_time, 1)-data_pred(start_time:end_time, 1), data_control(start_time:end_time, 2)-data_pred(start_time:end_time, 2),'Color',[0.5255    0.7137    0.9647],'LineWidth', 1.5);
 plot(start_time:end_time,data_control(start_time:end_time, 1)-data_pred(start_time:end_time, 1),'LineWidth', 2.5);
 plot(start_time:end_time,data_controlrc(start_time:end_time, 1)-data_predrc(start_time:end_time, 1),'LineWidth', 2.5);
% plot(data_controlrc(start_time:end_time, 1)-data_predrc(start_time:end_time, 1), data_controlrc(start_time:end_time, 2)-data_predrc(start_time:end_time, 2),'Color',[0.5255    0.2902    0.9765],'LineWidth', 1.5);

ax = gca;

set(ax, 'FontSize', 16); 
set(ax, 'XColor', 'k', 'LineWidth', 1); 

xlabel('','fontsize',16,'fontname','Times','FontWeight','bold')	
% ylabel('Tracking error of x-axis ','fontsize',16,'fontname','Times')	
legend('OIT2-FCM', 'RC')
box on

% reference trajectory 
figure();
hold on
% plot(data_control(start_time:end_time, 1)-data_pred(start_time:end_time, 1), data_control(start_time:end_time, 2)-data_pred(start_time:end_time, 2),'Color',[0.5255    0.7137    0.9647],'LineWidth', 1.5);
 plot(start_time:end_time,data_control(start_time:end_time, 2)-data_pred(start_time:end_time, 2),'LineWidth', 2.5);
 plot(start_time:end_time,data_controlrc(start_time:end_time, 2)-data_predrc(start_time:end_time, 2),'LineWidth', 2.5);
% plot(data_controlrc(start_time:end_time, 1)-data_predrc(start_time:end_time, 1), data_controlrc(start_time:end_time, 2)-data_predrc(start_time:end_time, 2),'Color',[0.5255    0.2902    0.9765],'LineWidth', 1.5);
ax = gca;

set(ax, 'FontSize', 16); 
set(ax, 'XColor', 'k', 'LineWidth', 1); 

xlabel('Time(sec)','fontsize',16,'fontname','Times','FontWeight','bold')	
% ylabel('Tracking error of y-axis ','fontsize',16,'fontname','Times')	
legend('OIT2-FCM', 'RC')
box on





