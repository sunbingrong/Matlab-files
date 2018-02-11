%% bifur����һ��ͼ
clc
clear
dirs=dir('D:/Matlab2014b/bin/bin�ļ�/bin��2015��/1.5-layer/��ʵ��ֲ��/*.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)' ;   
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;
c=zeros(13,12);
error=zeros(12,12);
for t=1:length(filenames)
    a=char(filenames(t));
    fid = load(a);
    bifur = fid(5401:end,2);
    a=reshape(bifur,[30,12,5]);
    b=sum(a,3)/5;
    c(t,:)=sum(b)/30;
end
for i=1:12
    error(i,:)=c(i+1,:)-c(1,:);
end
    RMSE=sqrt(sum(error.*error,2)/12);
    plot(RMSE,'bo-')
    xlim([1 12])