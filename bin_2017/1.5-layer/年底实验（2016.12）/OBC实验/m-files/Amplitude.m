% ƽ��λ��
clc
clear
dirs=dir('../Output/OBC*PHI.dat');
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
    d(t)=max(c)-min(c);
end
x=1:t;
%plot(x,d,'-b','LineWidth',2)
plot(x,d,'-bo','LineWidth',2,'MarkerFaceColor','b','MarkerSize',8)
xlim([1,t])
ylim([1,1.5])
hold on
%plot(x(end),d(end),'r*','LineWidth',3.5)
ylabel('Latitude(��)');
title('The Amplitude of  NEC bifurcation')
set(gca,'XTick',1:t);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W','Ctrl'});
set(gca,'YTick',1:0.1:1.5)
%saveas(gcf,'../Output/orlanski_Amplitude.bmp')