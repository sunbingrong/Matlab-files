% ���϶�γ��
clc
clear
dirs=dir('D:/Applications/Matlab2015b/bin/bin�ļ�/bin��2015��/1.5-layer/��ʵ��ֲ��/*.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)' ;   
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;
% ����CΪ���п���ʵ��ֲ���λ��
C = zeros(length(filenames),12);
for t=1:length(filenames)
    a=char(filenames(t));
    fid = load(a);
    bifur = fid(3601:end,2);
    a=reshape(bifur,[30,12,10]);
    b=sum(a,3)/10;
    c=sum(b)/30;
    d(t) = min(c);
    if (t == 1) 
         basic = d(t);
    end
    C(t,:) = c;
end
    x=1:13;
    plot(x,d,'-bo','LineWidth',1)
    xlim([1,13])
    hold on
    ylabel('Latitude(��N)');
    title('The Southest Latitude of NEC Bifurcation')
    y = basic*ones(13,1);
    plot(x,y,'-r','LineWidth',1.5);
    set(gca,'XTick',1:13);
    set(gca,'XTickLabel',{'Control','140E','150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W'});