%% 数据处理（第二问）
clear
[num,txt] = xlsread('欧冠成绩.xlsx');
data = num;
ZJ=zeros(12,20);
for k=12
    k
    m=14;
    L=15;
ZJ(k,1:15)=data(k,:);
n=5;
w=[1/12;1/12;2/12;3/12;5/12];
while m<19
    m=m+1;
  for i=1:m-n+1
      ZJyuce(k,i)=ZJ(k,i:i+n-1)*w;
  end
  err=abs(ZJ(k,n+1:m)-ZJyuce(k,1:end-1))./ZJ(k,n+1:m);
  T_err=1-sum(ZJyuce(k,1:end-1))/sum(ZJ(k,n+1:m));
  ZJyuce(k,end)=ZJyuce(k,end)/(1-T_err);
  L=L+1;
  ZJ(k,1:L)=[ZJ(k,1:L-1) ZJyuce(k,end)];
end
end