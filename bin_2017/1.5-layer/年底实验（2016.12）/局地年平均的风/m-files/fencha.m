% basic��100E-70w ��ƽ���ķ紵������bifurcation��������180E,150E���ı߽�����
% case1��100E-180E ����ͬ���ķ紵������
% case2��100E-150E��ͬcase1
% case3��100E-150E ���߽�������ǰ��һ���µ���λ
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
    bifur = fid(5401:end,2);
    a=reshape(bifur,[30,12,5]);
    b=sum(a,3)/5;
    c=sum(b)/30;
    subplot(4,4,t);
    plot([1:24],[c c],'-bo','LineWidth',1.5)
    set(gca,'XTick',1:24);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    ylabel('Latitude(��N)');
    title(['case',num2str(140+10*(t-1)),'E'])
end
scrsz = get(0,'ScreenSize');
set(gcf,'Position',scrsz);
set(gcf, 'PaperPositionMode', 'auto') 
saveas(gcf,'../Output/Bifurcation_meanwind.bmp');