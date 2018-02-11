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
    d(t)=max(c)-min(c);
end
x=1:t;
%plot(x,d,'-b','LineWidth',2)
plot(x,d,'-bo','LineWidth',2,'MarkerFaceColor','b','MarkerSize',8)
xlim([1,t])
ylim([1,1.5])
hold on
%plot(x(end),d(end),'r*','LineWidth',3.5)
ylabel('Latitude(°)');
title('The Amplitude of  NEC bifurcation')
set(gca,'XTick',1:t);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W','Ctrl'});
set(gca,'YTick',1:0.1:1.5)
%saveas(gcf,'../Output/orlanski_Amplitude.bmp')