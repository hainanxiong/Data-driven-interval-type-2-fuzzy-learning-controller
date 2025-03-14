clc 
clear
close all

load('./data/TrainX');
load('./data/TrainY');

% load('./IT2FCM-Offline/tao1_weight/tao1_G.mat');
% load('./tao1_weight/tao1_vl.mat');
% load('./tao1_weight/tao1_vr.mat');

% columns_to_extract_tao1 = [1,3,5,7]; % 要提取的列索引
% data_tao1 = train_x(:,columns_to_extract_tao1); % 提取指定列
% [m,n] = size(data_tao1);
% data=data_tao1;    % 训练feature
% yt = train_y(:,1); % 训练target  y_tao1

% load('./tao2_weight/tao2_G.mat');
% load('./tao2_weight/tao2_vl.mat');
% load('./tao2_weight/tao2_vr.mat');

% columns_to_extract_tao2 = [2,4,6,8];
data_tao2 = train_x(1:4000:end,:); 
[m,n] = size(data_tao2);
data=data_tao2;    % 训练feature
yt = train_y(1:4000:end,:); % 训练target  y_tao2

%% 训练获取最优的权重
cluster_num=10; %规则的数量

tic;
[y_pre,vl,vr,G] = IT2FCM.Method(data,rand(cluster_num,n),yt,'euclidean',2,2,3);
% 保存tao1的权重
% G1 = G; vl1 = vl; vr1 = vr;
% save(['./IT2FCM-Offline/tao1_weight/tao1_G', '.mat'], 'G1')
% save(['./IT2FCM-Offline/tao1_weight/tao1_vl', '.mat'], 'vl1')
% save(['./IT2FCM-Offline/tao1_weight/tao1_vr', '.mat'], 'vr1')

% 保存tao2的权重
% G2 = G; vl2 = vl; vr2 = vr;
% save(['./IT2FCM-Offline/tao2_weight/tao2_G', '.mat'], 'G2')
% save(['./IT2FCM-Offline/tao2_weight/tao2_vl', '.mat'], 'vl2')
% save(['./IT2FCM-Offline/tao2_weight/tao2_vr', '.mat'], 'vr2')
% t = toc;

%% 用最优的权重来测试
% v2=(vl+vr)/2;
% %U为隶属度矩阵，10*414
% [U,~]=Utility.cal_U(data,v2,2,size(v2,1));
% %rho为10*414
% rho=U./sum(U);
% rho=rho';
%         
% %LL为10，即规则数
% LL=size(v2,1);
% %N为414，即样本数
% N=size(data,1);
% x = [data ones(size(data,1), 1)];
% M=size(x,2);
% %X为系数矩阵，维度为414*70
% X=zeros(N,LL*M);
% for loop1 = 1:LL
%     for loop2 =1:N
%         X(loop2,((loop1-1)*M+1):loop1*M)=rho(loop2,loop1)*x(loop2,:);
%     end
% end
% t2t=X*G; % 预测最终的结果


figure(1)
hold on
plot(1:length(yt),y_pre(:,1),'b');
plot(1:length(yt),yt(:,1),'r--'); 
legend('yp','yt');
xlabel('n');
ylabel('y');

figure(2)
hold on
plot(1:length(yt),y_pre(:,2),'b');
plot(1:length(yt),yt(:,2),'r--'); 
legend('yp','yt');
xlabel('n');
ylabel('y');






