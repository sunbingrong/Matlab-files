%% ׼���1�ĳɶԱȽϾ���
% �����е�������Ⱥ
clear
% С������ 5  ��ҵ 4 ҽ�� 4 ��ͨ 8  ���� 8 �ܱ߻��� 5 ���ø��� 6
A = [1 3 3 1/5 1/5 1 1/3; ...
     1/3 1 1 1/6 1/6 1/3 1/4; ... 
     1/3 1 1 1/6 1/6 1/3 1/4; ... 
     5 6 6 1 1 5 4; ...
     5 6 6 1 1 5 4; ...
     1 3 4 1/5 1/5 1 1/3; ... 
     3 4 4 1/4 1/4 3 1];
[x,lamda] = eig(A);
lamda_max = max(max(lamda));   %�õ��������ֵ
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %�õ������������
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %���滯��������
end
W = x_1;
%% ����7������ 12����������ıȽ�
% ����С������ 12�������໥�ĶԱ�
load Community.mat
% ���� ��ҵ �໥�ĶԱ�
load Business.mat
% ���� ҽ��  12��С���ĶԱ�
load Medical.mat
% ���� ��ͨ  12��С���ĶԱ�
load traffic_weight.mat
% ���� ����  12��С���ĶԱ�
load education_weight.mat
% �����ܱ߻��� 12�������ıȽ�
load environment_weight.mat
% ���� ���ø��� 12�������ıȽ�
load price.mat % ���Ӱ���100ƽ�׼���, ����8��, 20�껹��
huankuan = [3664 4188 3403 3403 7329 8900 12565 19371 6282 12041 23559 4502];
burden = huankuan/25000;
burden_weight = burden/sum(burden);
%% ���� ���Ľ��
% ����12��С�����
load M_W.mat
score=M_W*[Community;Business;Medical;traffic_weight;education_weight;environment_weight;-burden_weight];
% ӳ���� 1-5 ���
max_score=max(score);
min_score=min(score);
level = 4/(max_score-min_score)*score + 5 - 4/(max_score-min_score)*max_score;
level = round(level);