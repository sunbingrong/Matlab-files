%% bifur����һ��ͼ
clc
clear
dirs=dir('../Output/*.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)' ;
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;
c=zeros(16,12);
error=zeros(15,12);
for t=1:length(filenames)
    a=['../Output/',char(filenames(t))];
    fid = load(a);
    bifur = fid(3601:end,2);
    a=reshape(bifur,[30,12,10]);
    b=sum(a,3)/10;
    c(t,:)=sum(b)/30;
end
for i=1:15
    error(i,:)=c(i+1,:)-c(end,:);
end
RMSE=sqrt(sum(error.*error,2)/12);
plot(RMSE,'bo-')
xlim([1 15])
set(gca,'XTickLabel',{'140E','150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W'});
scrsz = get(0,'ScreenSize');
set(gcf,'Position',scrsz);
set(gcf, 'PaperPositionMode', 'auto')
saveas(gcf,'../Output/Run_RMSE.bmp')