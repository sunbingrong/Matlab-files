clear;
CoreNum=4; %�趨����CPU�����������ҵĻ�����˫�ˣ�����CoreNum=2
tic
%��ͳ��ʽ����
c1=1;
for i = 1:500
    c1 = c1+max(eig(rand(i,i)));
end
t1 = toc;
%parfor���з�ʽ����
parpool local
tic
c2=1;
parfor ii = 1:500
    c2 = c2+max(eig(rand(ii,ii)));
end
t2 = toc;
display(strcat('parfor���м���ʱ�䣺',num2str(t2),'��'));
display(strcat('�ͻ��˴��м���ʱ�䣺',num2str(t1),'��'));