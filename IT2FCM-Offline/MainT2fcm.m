clc 
clear
close all

load('./data/TrainX');
load('./data/TrainY');

% load('./IT2FCM-Offline/tao1_weight/tao1_G.mat');
% load('./tao1_weight/tao1_vl.mat');
% load('./tao1_weight/tao1_vr.mat');

% columns_to_extract_tao1 = [1,3,5,7]; 
% data_tao1 = train_x(:,columns_to_extract_tao1); 
% [m,n] = size(data_tao1);
% data=data_tao1;    
% yt = train_y(:,1);  

% load('./tao2_weight/tao2_G.mat');
% load('./tao2_weight/tao2_vl.mat');
% load('./tao2_weight/tao2_vr.mat');

% columns_to_extract_tao2 = [2,4,6,8];
data_tao2 = train_x(1:4000:end,:); 
[m,n] = size(data_tao2);
data=data_tao2;   
yt = train_y(1:4000:end,:); 


cluster_num=10; 

tic;
[y_pre,vl,vr,G] = IT2FCM.Method(data,rand(cluster_num,n),yt,'euclidean',2,2,3);

% G1 = G; vl1 = vl; vr1 = vr;
% save(['./IT2FCM-Offline/tao1_weight/tao1_G', '.mat'], 'G1')
% save(['./IT2FCM-Offline/tao1_weight/tao1_vl', '.mat'], 'vl1')
% save(['./IT2FCM-Offline/tao1_weight/tao1_vr', '.mat'], 'vr1')

% G2 = G; vl2 = vl; vr2 = vr;
% save(['./IT2FCM-Offline/tao2_weight/tao2_G', '.mat'], 'G2')
% save(['./IT2FCM-Offline/tao2_weight/tao2_vl', '.mat'], 'vl2')
% save(['./IT2FCM-Offline/tao2_weight/tao2_vr', '.mat'], 'vr2')
% t = toc;

% v2=(vl+vr)/2;
% [U,~]=Utility.cal_U(data,v2,2,size(v2,1));
% %rho为10*414
% rho=U./sum(U);
% rho=rho';
%         

% LL=size(v2,1);
% N=size(data,1);
% x = [data ones(size(data,1), 1)];
% M=size(x,2);
% X=zeros(N,LL*M);
% for loop1 = 1:LL
%     for loop2 =1:N
%         X(loop2,((loop1-1)*M+1):loop1*M)=rho(loop2,loop1)*x(loop2,:);
%     end
% end
% t2t=X*G; 


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






