clc
clear
close all

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

figure(); % 
X = [5000000,20000500]; 
hold on
% color_matrix = [0.7961    0.0039    0.1961;0.0627    0.1373    0.7647];                
for i = 1:2
    b = bar(i,X(i),0.75,'stacked');  
    set(b(1),'facecolor')
end
box on
Xlabel = {'OIT2-FCM','RC'};
set(gca,'XTick',[1 2]);
set(gca,'XTickLabel',Xlabel);
ylabel('Number of sample') 
set(gca,'FontSize',15,'Fontname', 'Arial');