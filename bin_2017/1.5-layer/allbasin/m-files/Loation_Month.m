% ƽ��λ��
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
plot(x,s1,'-ro',x,s2,'-bo','LineWidth',1.5)
xlim([1,t])
hold on
ylabel('Month');
set(gca,'XTick',1:t);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W','Control'});
set(gca,'YTick',1:12);
set(gca,'YTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
title('Locaton month of Southest and Northest Bifurcation')
saveas(gcf,'../Output/Location_Month.bmp')