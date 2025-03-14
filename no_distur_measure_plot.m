clc
clear
close all

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

% load('./no_distur_measure/01_lorenz.mat')
% load('./no_distur_measure/02_rossler.mat')
% load('./no_distur_measure/03_chua.mat')
% load('./no_distur_measure/04_circle.mat')
load('./no_distur_measure/05_astroid.mat')
% load('./no_distur_measure/06_epitrochoid.mat')

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

% 离线框图里面的轨迹作图
% figure();
% hold on
% plot(data_control(start_time:end_time, 1), data_control(start_time:end_time, 2), 'Color',[0.4078    0.4941    1.0000],'LineWidth',1);
% plot(data_pred(start_time:end_time, 1), data_pred(start_time:end_time, 2),'--','Color',[0.8706    0.5608    0.3725],'LineWidth',1);
% % plot(data_predrc(start_time:end_time, 1), data_predrc(start_time:end_time, 2));
% xlabel('Time,$t$')
% % legend('reference','with_distur_measure', 'no_distur_measure')
% axis off

val_length = 200000;
    

figure();
hold on
plot(data_control(start_time:end_time, 1), data_control(start_time:end_time, 2),'LineWidth', 2.5);
plot(data_pred(start_time:end_time, 1), data_pred(start_time:end_time, 2),'LineStyle', '--','LineWidth', 2.5);
% xlim([-1, 1])
% ylim([-1, 1])
legend('Reference trajectory', 'Actual trajectory')
ax = gca;
set(ax, 'FontSize', 15); 
set(ax, 'XColor', 'k', 'LineWidth', 1);
box on
% axis off;


