%% 数据读取
[num,txt] = xlsread('数据.xlsx')
num(:,4) = [];
data = num;
%% 极差归一化
dmin = min(data);
dmax = max(data);
dmm = dmax - dmin;
numb = 12;
ndata = data;
for i = 1:numb
    ndata(i,:) = (data(i,:) - dmin)./dmm;
end
ndata
% 计算系数矩阵
ndacf = corrcoef(ndata);
[V,D] = eig(ndacf)
l = D(1)/sum(sum(D))% 计算贡献度
V = -V;
%主成分排名
sc = ndata*V(:,1);
[b,in] = sort(sc,'descend');
txt(1+in,1)
head = {'排 名','得 分','俱乐部'};
disp([head;num2cell((1:numb)'),num2cell(b),txt(1+in,1)])