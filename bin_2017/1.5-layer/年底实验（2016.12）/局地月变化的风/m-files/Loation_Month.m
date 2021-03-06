% 平均位置
clc
clear
dirs=dir('../Output/case*.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;

for t=1:length(filenames)
    a=['../Output/',char(filenames(t))];
    fid = load(a);
    bifur = fid(3601:end,2);
    a=reshape(bifur,[30,12,10]);
    b=sum(a,3)/10;
    c=sum(b)/30;
    [~,s1(t)]=max(c);
    [~,s2(t)]=min(c);
end
s1(2) = 12;
x=1:t;
plot(x,s1,'-ro',x,s2,'-bo','LineWidth',1.5)
xlim([1,t])
hold on
plot(x(end),s1(end),'-r*',x(end),s2(end),'-b*','LineWidth',3.5)
ylabel('Month');
set(gca,'XTick',1:t);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W','Control'});
set(gca,'YTick',1:12);
set(gca,'YTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
title('Locaton month of Southest and Northest Bifurcation')
%saveas(gcf,'../Output/orlanski_Location_Month.bmp')