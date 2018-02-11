%% ����
contourf(case2_NPC)
hold on
set(gca,'ytick',[1:60:241])
set(gca,'yticklabel',{'0��','10��N','20��N','30��N','40��N'})
set(gca,'xtick',[1:80:321])
set(gca,'xticklabel',{'100��E','120��E','140��E','160��E','180��E'})
f = getframe(gca);
image = frame2im(f);
%imwrite(image,'1.png')
%% Introduction
% basic��100E-70w ��ƽ���ķ紵������bifurcation��������180E,150E���ı߽�����
% case1��100E-180E ����ͬ���ķ紵������
% case2��100E-150E��ͬcase1
% case3��100E-150E ���߽�������ǰ��һ���µ���λ
%��һ��Ϊ4�㣬�ڶ���Ϊ8�㣬������Ϊ12��
%% basicʵ�飬��������̬�ķֲ��λ��
load basic_bifur_PHI.dat
basic_bifur = allbasin140E_bifur_PHI_1_(3601:end,2);
a=reshape(basic_bifur,[30,12,10]);
b=sum(a,3)/10;
c=sum(b)/30;
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(��N)');
%% bifur����һ��ͼ
clc
clear
dirs=dir('D:/Applications/Matlab2015b/bin/bin�ļ�/bin��2015��/1.5-layer/ȫ�ֺ���_����ƽ����ʵ��ֲ��/allstill*.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)' ;   
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;

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
    ylabel('Latitude(��N)');
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
% ylabel('Latitude(��N)');
% title('Basic control')
%% bifur��ͼ
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(��N)');