clc
clear
close all
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

addpath('./IT2FCM-Offline/')

% choose the reference trajectory
traj_type = 'epitrochoid';
% traj_type = 'astroid'; 
% traj_type = 'circle';

time_infor.val_length=200000;
bridge_type = 'cubic';
failure.type = 'none';
disturbance = 0.00;
measurement_noise = 0.00;
plot_movie = 0;
blur.blur = 0;

save_rend = 0;
idx = 0;

plot_val_and_update = 1;

% training network
% func_arm

% let the well-trained machine to follow the given reference.
val_update