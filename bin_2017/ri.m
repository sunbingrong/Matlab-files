function ri                   %%����R.I.ֵ
m=1000;
ri=zeros(9,1);
for n=1:9
rand('seed',21)               %%�������������
for i=1:m
a=ceil(17*rand(n));           %%����n��1��17�������
a(a==8)=8.1;                   %%����0Ϊ��ĸ
b=1./(a-8);                    %%����һ��������
a(a>9)=b(a>9);                %%����b����9��17�ֱ�ת��Ϊ1/2��1/9
a(a==8.1)=8;
e = eye(n);                    %%����һ����λ��
c = 1./a;                     
c = c';
c = tril(c,-1);               %%��ȡ������
a = triu(a,1);                %%��ȡ������
a = a+c+e;
k = size(a,1);
ri(n)= ri(n)+(max(abs(eig(a)))-k)/(k-1);  %%����1000��R.I.��ֵ
end
ri(n)=ri(n)/m;             %%����ƽ��R.I.ֵ
end
fprintf('hello world is %8.5f\n',ri)
