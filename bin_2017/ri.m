function ri                   %%计算R.I.值
m=1000;
ri=zeros(9,1);
for n=1:9
rand('seed',21)               %%控制随机发生器
for i=1:m
a=ceil(17*rand(n));           %%产生n阶1—17的随机阵
a(a==8)=8.1;                   %%消除0为分母
b=1./(a-8);                    %%产生一个辅助阵
a(a>9)=b(a>9);                %%借助b，将9—17分别转化为1/2—1/9
a(a==8.1)=8;
e = eye(n);                    %%生成一个单位阵
c = 1./a;                     
c = c';
c = tril(c,-1);               %%抽取下三角
a = triu(a,1);                %%抽取上三角
a = a+c+e;
k = size(a,1);
ri(n)= ri(n)+(max(abs(eig(a)))-k)/(k-1);  %%计算1000次R.I.的值
end
ri(n)=ri(n)/m;             %%计算平均R.I.值
end
fprintf('hello world is %8.5f\n',ri)
