clc
clear
close all

addpath('./tools/')

% load('./no_distur_measure/01_lorenz.mat')
% load('./rc_data/01_lorenz.mat')

% load('./no_distur_measure/02_rossler.mat')
% load('./rc_data/02_rossler.mat')

% load('./no_distur_measure/03_chua.mat')
% load('./rc_data/03_chua.mat')

% load('./no_distur_measure/04_circle.mat')
% load('./rc_data/04_circle.mat')

% load('./no_distur_measure/05_astroid.mat')
% load('./rc_data/05_astroid.mat')

load('./no_distur_measure/06_epitrochoid.mat')
load('./rc_data/06_epitrochoid.mat')

rmse_start_time=1;
rmse_end_time=200100-100;
control_infor=no_infor;

data_pred=control_infor.data_pred;
data_control=control_infor.data_control;

data_predrc=rc_infor.data_pred;
data_controlrc=rc_infor.data_control;

rmse_meefnn = func_rmse(data_pred, data_control, rmse_start_time, rmse_end_time);
disp(rmse_meefnn)

rmse_rc = func_rmse(data_predrc, data_controlrc, rmse_start_time, rmse_end_time);
disp(rmse_rc)
