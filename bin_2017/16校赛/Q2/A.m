%% 准则层1的成对比较矩阵
clear
% 小区环境 7  商业 3 医疗 4 交通 6  教育 7 周边环境 8
A = [1 7 5 3 1 1/3; ...
     1/7 1 1/3 1/6 1/7 1/8; ... 
     1/5 3 1 1/4 1/5 1/6; ... 
     1/3 6 4 1 1/3 1/4; ...
     1 7 5 3 1 1/2; ... 
     3 8 6 4 2 1];
[x,lamda] = eig(A);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
%% 对于小区景观 相互的对比
clear
% 规划户数 4 绿化率 8  容积率 6
B1=[1 1/4 1/3;4 1 2;3 1/2 1];
[x1,lamda1] = eig(B1);
lamda_max1 = max(max(lamda1));   %得到最大特征值
[s,t] = find(lamda1==lamda_max1);  
x_max1 = x1(:,t);                %得到最大特征向量
n = length(x_max1);  
for i=1:n
    x_1(i) = x_max1(i)/sum(x_max1);  %正规化特征向量
end
W1 = x_1;
%% 对于 商业 相互的对比
% 购物 4 银行 3 餐饮 8
clear
B2=[1 2 1/4;1/2 1 1/5;4 5 1];
[x2,lamda2] = eig(B2);
lamda_max2 = max(max(lamda2));   %得到最大特征值
[s,t] = find(lamda2==lamda_max2);  
x_max2 = x2(:,t);                %得到最大特征向量
n = length(x_max2);  
for i=1:n
    x_2(i) = x_max2(i)/sum(x_max2);  %正规化特征向量
end
W2 = x_2;
%% 对于 小区环境 12个地区的对比
% 规划户数
load living.mat
n = length(living);
living=-8/1506*living + 9 - 240*(-8/1506);
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = living(i)./living(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
% 绿化率
load green.mat
n = length(green);
green=18.0995*green - 2.4027;
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = green(i)./green(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
% 容积率
load volume.mat
n = length(volume);
volume=-5/3*volume + 11;
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = volume(i)./volume(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
%% 对于 商业  12个小区的对比
%  对于购物
load shopping.mat
n = length(shopping);
shopping=4/3*shopping+1;
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = shopping(i)./shopping(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
% 银行
load bank.mat
n = length(bank);
bank=8/7*bank+1;
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = bank(i)./bank(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
% 餐饮
load eat.mat
n = length(eat);
eat=2*eat+1;
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = eat(i)./eat(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
%% 对于 医疗  12个小区的对比
load health.mat
n = length(health);
health=4/3*health+1;
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = health(i)./health(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
%% 对于 交通  12个小区的对比
load traffic.mat
n = length(traffic);
traffic=8/3*traffic-5/3;
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = traffic(i)./traffic(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
%% 对于 教育  12个小区的对比
load education.mat
n = length(education);
education=8/11*education + 3/11;
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = education(i)./education(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
%% 对于周边环境 12个地区的比较
load environment.mat
n = length(envirment);
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = envirment(i)./envirment(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
%% 整理 最后的结果
%  对于小区（规划户数 绿化率 容积率）
Community=W1*[living_weight;green_weight;volume_weight];
% 对于 商业
Business=W2*[shopping_weight;bank_weight;eat_weight];
% 对于 医疗
load Medical.mat
% 对于 交通
load traffic_weight.mat
% 对于 教育
load  education_weight.mat
% 对于 周边环境
load environment_weight.mat
% 最后对12个小区打分
load W.mat
score=W*[Community;Business;Medical;traffic_weight;education_weight;environment_weight];