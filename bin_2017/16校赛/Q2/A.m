%% ׼���1�ĳɶԱȽϾ���
clear
% С������ 7  ��ҵ 3 ҽ�� 4 ��ͨ 6  ���� 7 �ܱ߻��� 8
A = [1 7 5 3 1 1/3; ...
     1/7 1 1/3 1/6 1/7 1/8; ... 
     1/5 3 1 1/4 1/5 1/6; ... 
     1/3 6 4 1 1/3 1/4; ...
     1 7 5 3 1 1/2; ... 
     3 8 6 4 2 1];
[x,lamda] = eig(A);
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
%% ����С������ �໥�ĶԱ�
clear
% �滮���� 4 �̻��� 8  �ݻ��� 6
B1=[1 1/4 1/3;4 1 2;3 1/2 1];
[x1,lamda1] = eig(B1);
lamda_max1 = max(max(lamda1));   %�õ��������ֵ
[s,t] = find(lamda1==lamda_max1);  
x_max1 = x1(:,t);                %�õ������������
n = length(x_max1);  
for i=1:n
    x_1(i) = x_max1(i)/sum(x_max1);  %���滯��������
end
W1 = x_1;
%% ���� ��ҵ �໥�ĶԱ�
% ���� 4 ���� 3 ���� 8
clear
B2=[1 2 1/4;1/2 1 1/5;4 5 1];
[x2,lamda2] = eig(B2);
lamda_max2 = max(max(lamda2));   %�õ��������ֵ
[s,t] = find(lamda2==lamda_max2);  
x_max2 = x2(:,t);                %�õ������������
n = length(x_max2);  
for i=1:n
    x_2(i) = x_max2(i)/sum(x_max2);  %���滯��������
end
W2 = x_2;
%% ���� С������ 12�������ĶԱ�
% �滮����
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
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
% �̻���
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
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
% �ݻ���
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
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
%% ���� ��ҵ  12��С���ĶԱ�
%  ���ڹ���
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
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
% ����
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
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
% ����
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
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
%% ���� ҽ��  12��С���ĶԱ�
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
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
%% ���� ��ͨ  12��С���ĶԱ�
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
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
%% ���� ����  12��С���ĶԱ�
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
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
%% �����ܱ߻��� 12�������ıȽ�
load environment.mat
n = length(envirment);
a1=zeros(n,n);
for i=1:n
    for j=1:n
        a1(i,j) = envirment(i)./envirment(j);
    end
end
[x,lamda] = eig(a1);
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
%% ���� ���Ľ��
%  ����С�����滮���� �̻��� �ݻ��ʣ�
Community=W1*[living_weight;green_weight;volume_weight];
% ���� ��ҵ
Business=W2*[shopping_weight;bank_weight;eat_weight];
% ���� ҽ��
load Medical.mat
% ���� ��ͨ
load traffic_weight.mat
% ���� ����
load  education_weight.mat
% ���� �ܱ߻���
load environment_weight.mat
% ����12��С�����
load W.mat
score=W*[Community;Business;Medical;traffic_weight;education_weight;environment_weight];