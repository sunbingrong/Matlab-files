% Introduction
% basic：100E-70w 月平均的风吹出来的bifurcation
%第一列为4点，第二列为8点，第三列为12点
% bifur画进一张图
clc
clear
dirs=dir('../Output/*PHI.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;

for t=1:length(filenames)
    a1=['../Output/',char(filenames(t))];
    fid = load(a1);
    bifur = fid(3601:end,2);
    a=reshape(bifur,[30,12,10]);
    b=sum(a,3)/10;
    c=sum(b)/30;
    subplot(4,4,t);
    plot([1:24],[c c],'-bo','LineWidth',1.5)
    set(gca,'XTick',1:24);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    ylabel('Latitude(°N)');
    ylim([min(c)-0.1 max(c)+0.1]);
    set(gca,'YTick',floor(min(c)):0.25:floor(max(c)));
    if t == length(filenames)
        title('Control Run : 290E')
    else
        title(['Eastern Boundary : ',num2str(150+10*(t-2)),'E'])
    end
    All_latitude(t,:)=c;
end
 %scrsz = get(0,'ScreenSize');
 %set(gcf,'Position',scrsz);
 %set(gcf, 'PaperPositionMode', 'auto')
 saveas(gcf,'../Output/OBC_Bifurcation.tif');
 save('../Output/All_latitude.mat','All_latitude');
%% CODAS windstress bifurcation 
fid = importdata('../Output/ECMWF290E_bifur_PHI.dat');
bifur = fid(end-3599:end,2);
a=reshape(bifur,[30,12,10]);
b=mean(a,3);
c=mean(b,1);
%c=smooth(c,3)';
plot([1:24],[c c],'-bo','LineWidth',2.0)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°N)');
ylim([min(c)-0.1 max(c)+0.1]);
%set(gca,'YTick',floor(min(c)):0.25:floor(max(c)));
title('Control  Run')
% scrsz = get(0,'ScreenSize');
% set(gcf,'Position',scrsz);
% set(gcf, 'PaperPositionMode', 'auto')
saveas(gcf,'../Output/ECMWF290E_bifur.tif');
%% 动能和势能
clear;
fid = load('../Output/dissi150E_stdout.dat');
kinetic = fid(:,4);
potential = fid(:,5);