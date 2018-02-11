% 平均位置
clc
clear
dirs=dir('../Output/OBC*PHI.dat');
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
x=1:t;
plot(x,s1,'-ks','LineWidth',2,'MarkerFaceColor','k','MarkerSize',8)
hold on
plot(x,s2,'-ko','LineWidth',2,'MarkerFaceColor','k','MarkerSize',8)
xlim([1,t])
set(gca,'XTick',1:t);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W'});
set(gca,'xlim',[0.5 15.5])
set(gca,'YTick',1:13);
set(gca,'YTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Jan'},'FontSize',14);
set(gca,'ylim',[0.5 13.5])
set(gca,'FontSize',12)
title('Locaton month of Southest and Northest Bifurcation','FontSize',12)
legend('N','S');
linesInPlot = findobj('type','line'); % linesInPlot(2)是线的控制句柄
xxx2 = get(linesInPlot(1),'XData'); % 返回的结果为 0.1231 0.7385
xxx2(1) = xxx2(1)+(xxx2(2)-xxx2(1))/2; %%起始点向前走0.5个原来的长度。。
set(linesInPlot(2),'XData',xxx2)
legend('boxoff')
%saveas(gcf,'../Output/orlanski_Location_Month.bmp')