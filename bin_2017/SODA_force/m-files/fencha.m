% Introduction
% basic：100E-70w 月平均的风吹出来的bifurcation
%第一列为4点，第二列为8点，第三列为12点
% bifur画进一张图
clc
clear
dirs=dir('../Output/basic*.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;
k = 0;
for EB=150:30:210
    k = k+1;
fid = importdata(['../Output/basicwind',num2str(EB),'E_bifur_PHI_soda.dat']);
bifur = fid(3601:end,2);
a=reshape(bifur,[30,12,10]);
b=mean(a,3);
c=mean(b,1);
subplot(1,3,k)
plot([1:24],[c c],'-bo','LineWidth',2,'MarkerFaceColor','b','MarkerSize',8)
c_min  = min(c); 
c_max = max(c);
p1=get(gca,'Position');
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month','FontSize',12);
ylabel('Latitude(°N)','FontSize',12);
 %set(gca,'ylim',[c_min  c_max+0.2])
 %set(gca,'yTick',ceil(c_min::c_max))
    if k == 1
        ylabel('Latitude(°N)');
        set(gca,'position',p1);
    else
        set(gca,'position',p1);
         ylabel('');
    end
    p1(1) = p1(1) -0.04*k;
    p1(2) = p1(2) + 0.02;
    set(gca,'position',p1);
    title(['EB\_', num2str(EB),'E'])
    All_latitude(k,:)=c;
end
%save('../Output/NBL_Sen.mat','NBL_Sen');
%save('../Output/NBL_Ctrl.mat','NBL_Ctrl');
%% case180E分叉点
fid = importdata('../Output/basicwind150E_bifur_PHI_soda.dat');
bifur = fid(3601:end,2);
a=reshape(bifur,[30,12,10]);
b=mean(a,3);
c=mean(b,1);
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°N)');
title('EB: 180E   BC: SODA')
% scrsz = get(0,'ScreenSize');
% set(gcf,'Position',scrsz);
% set(gcf, 'PaperPositionMode', 'auto')
%saveas(gcf,'../Output/180E_bifur.bmp');
%% 动能和势能
clear;
fid = load('../Output/dissi150E_stdout.dat');
kinetic = fid(:,4);
potential = fid(:,5);