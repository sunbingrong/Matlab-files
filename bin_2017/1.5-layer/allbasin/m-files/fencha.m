% Introduction
% basic��100E-70w ��ƽ���ķ紵������bifurcation
%��һ��Ϊ4�㣬�ڶ���Ϊ8�㣬������Ϊ12��
% bifur����һ��ͼ
clc
clear
dirs=dir('../Output/*.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)' ;
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;

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
    ylabel('Latitude(��N)');
    title(['case',num2str(140+10*(t-1)),'E'])
    All_latitude(t,:)=c;
end
scrsz = get(0,'ScreenSize');
set(gcf,'Position',scrsz);
set(gcf, 'PaperPositionMode', 'auto')
saveas(gcf,'../Output/Bifurcation_seasonalwind.bmp');
save('../Output/All_latitude.mat','All_latitude');
%% controlʵ��ķֲ��
fid = load('../Output/case290E_bifur_PHI.dat');
bifur = fid(3601:end,2);
a=reshape(bifur,[30,12,10]);
b=sum(a,3)/10;
c=sum(b)/30;
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(��N)');
title('Control Run bifurcation')
% scrsz = get(0,'ScreenSize');
% set(gcf,'Position',scrsz);
% set(gcf, 'PaperPositionMode', 'auto')
saveas(gcf,'../Output/control_bifur.bmp');
%% 180Eʵ��ķֲ��
fid = load('../Output/allbasin180E_bifur_PHI.dat');
bifur = fid(3601:end,2);
a=reshape(bifur,[30,12,10]);
b=sum(a,3)/10;
c=sum(b)/30;
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(��N)');
%title('Control Run bifurcation')
% scrsz = get(0,'ScreenSize');
% set(gcf,'Position',scrsz);
% set(gcf, 'PaperPositionMode', 'auto')
saveas(gcf,'../Output/180E_bifur.bmp');