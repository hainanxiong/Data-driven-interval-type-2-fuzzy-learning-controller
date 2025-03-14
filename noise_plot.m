clc
clear
close all

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

load('./distur_measure/01mg_17.mat')
% load('./distur_measure/02rossler.mat')
% load('./distur_measure/03sprott_1.mat')
% load('./distur_measure/04astroid.mat')
% load('./distur_measure/05infty.mat')
% load('./distur_measure/06heart.mat')

start_time=1;
end_time=200100-100;


data_pred=with_infor.data_pred;
q_pred=with_infor.q_pred;
qdt_pred=with_infor.qdt_pred;
q2dt_pred=with_infor.q2dt_pred;
tau_pred=with_infor.tau_pred;

q_control=with_infor.q_control;
qdt_control=with_infor.qdt_control;
q2dt_control=with_infor.q2dt_control;
tau_control=with_infor.tau_control;
data_control=with_infor.data_control;

% reference trajectory 误差 C_x方向
figure();
hold on
plot(data_control(start_time:end_time, 1), data_control(start_time:end_time, 2),'LineWidth', 2.5);
plot(data_pred(start_time:end_time, 1), data_pred(start_time:end_time, 2),'LineStyle', '--','LineWidth', 2.5);
% xlim([-1, 1])
% ylim([-1, 1])
% 获取当前坐标轴句柄
ax = gca;

% 设置x轴和y轴刻度加粗
set(ax, 'FontSize', 15); % 使坐标轴上的字体加粗
set(ax, 'XColor', 'k', 'LineWidth', 1); % 使坐标轴加粗
legend('Reference trajectory', 'Actual trajectory')
box on
