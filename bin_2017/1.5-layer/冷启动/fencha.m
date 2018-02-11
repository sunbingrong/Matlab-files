%% 地形
contourf(case2_NPC)
hold on
set(gca,'ytick',[1:60:241])
set(gca,'yticklabel',{'0°','10°N','20°N','30°N','40°N'})
set(gca,'xtick',[1:80:321])
set(gca,'xticklabel',{'100°E','120°E','140°E','160°E','180°E'})
f = getframe(gca);
image = frame2im(f);
%imwrite(image,'1.png')
%% Introduction
% basic：100E-70w 月平均的风吹出来的bifurcation，并产生180E,150E处的边界条件
% case1：100E-180E 内区同样的风吹出来的
% case2：100E-150E，同case1
% case3：100E-150E ，边界条件提前了一个月的相位
%第一列为4点，第二列为8点，第三列为12点
%% basic实验，计算气候态的分叉点位置
load basic_bifur_PHI.dat
basic_bifur = allbasin140E_bifur_PHI_1_(3601:end,2);
a=reshape(basic_bifur,[30,12,10]);
b=sum(a,3)/10;
c=sum(b)/30;
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°N)');
%% bifur画进一张图
clc
clear
dirs=dir('D:/Applications/Matlab2015b/bin/bin文件/bin（2015）/1.5-layer/全局海盆_东部平均风实验分叉点/allstill*.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;   
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;

for t=1:length(filenames)
    a=char(filenames(t));
    fid = load(a);
    bifur = fid(5401:end,2);
    a=reshape(bifur,[30,12,5]);
    b=sum(a,3)/5;
    c=sum(b)/30;
    subplot(3,4,t);
    plot([1:24],[c c],'-bo','LineWidth',1.5)
    set(gca,'XTick',1:24);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    ylabel('Latitude(°N)');
    title(['case',num2str(140+10*(t-1)),'E'])
end
% hold on 
% load basic_bifur_PHI.dat
% basic_bifur = basic_bifur_PHI(3601:end,2);
% a=reshape(basic_bifur,[30,12,10]);
% b=sum(a,3)/10;
% c=sum(b)/30;
% subplot(3,4,12)
% plot([1:24],[c c],'-bo','LineWidth',1.5)
% set(gca,'XTick',1:24);
% set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
% xlabel('Month');
% ylabel('Latitude(°N)');
% title('Basic control')
%% bifur画图
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°N)');