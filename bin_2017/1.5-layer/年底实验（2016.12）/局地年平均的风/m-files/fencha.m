% basic：100E-70w 月平均的风吹出来的bifurcation，并产生180E,150E处的边界条件
% case1：100E-180E 内区同样的风吹出来的
% case2：100E-150E，同case1
% case3：100E-150E ，边界条件提前了一个月的相位
%第一列为4点，第二列为8点，第三列为12点
% bifur画进一张图
clc
clear
dirs=dir('../Output/*.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;   
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;

for t=1:length(filenames)
    a1=['../Output/',char(filenames(t))];
    fid = load(a1);
    bifur = fid(5401:end,2);
    a=reshape(bifur,[30,12,5]);
    b=sum(a,3)/5;
    c=sum(b)/30;
    subplot(4,4,t);
    plot([1:24],[c c],'-bo','LineWidth',1.5)
    set(gca,'XTick',1:24);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    ylabel('Latitude(°N)');
    title(['case',num2str(140+10*(t-1)),'E'])
end
scrsz = get(0,'ScreenSize');
set(gcf,'Position',scrsz);
set(gcf, 'PaperPositionMode', 'auto') 
saveas(gcf,'../Output/Bifurcation_meanwind.bmp');