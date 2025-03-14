clc
clear
close all

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

figure(); % 不弹出figure窗口，由于最后我把结果保存了下来，所以选择不弹出窗口，直接保存
X = [5000000,20000500]; 
hold on
% color_matrix = [0.7961    0.0039    0.1961;0.0627    0.1373    0.7647];  %每个柱子的颜色设置
%一个个添加柱子，用b记录，此时调用b(i)的facecolor就可以用来修改颜色               
for i = 1:2
    b = bar(i,X(i),0.75,'stacked');  %0.75是柱形图的宽，可以更改
%     set(b(1),'facecolor',color_matrix(i,:))
    set(b(1),'facecolor')
end
box on
Xlabel = {'OIT2-FCM','RC'};
set(gca,'XTick',[1 2]);
set(gca,'XTickLabel',Xlabel);%设置柱状图每个柱子的横坐标
% set(gca,'YLim',[0.6 1]);%设置纵坐标的数值间隔
ylabel('Number of sample') 
%xlabel(str) %设置横坐标的名字 
set(gca,'FontSize',15,'Fontname', 'Arial');