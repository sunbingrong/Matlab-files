%% ���ݶ�ȡ
[num,txt] = xlsread('����.xlsx')
num(:,4) = [];
data = num;
%% �����һ��
dmin = min(data);
dmax = max(data);
dmm = dmax - dmin;
numb = 12;
ndata = data;
for i = 1:numb
    ndata(i,:) = (data(i,:) - dmin)./dmm;
end
ndata
% ����ϵ������
ndacf = corrcoef(ndata);
[V,D] = eig(ndacf)
l = D(1)/sum(sum(D))% ���㹱�׶�
V = -V;
%���ɷ�����
sc = ndata*V(:,1);
[b,in] = sort(sc,'descend');
txt(1+in,1)
head = {'�� ��','�� ��','���ֲ�'};
disp([head;num2cell((1:numb)'),num2cell(b),txt(1+in,1)])