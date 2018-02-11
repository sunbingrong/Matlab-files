%% 准则层1的成对比较矩阵
% 对于中等收入人群
clear
% 小区环境 2  商业 4 医疗 4 交通 4  教育 5 周边环境 2 经济负担 9
A = [1 1/4 1/4 1/4 1/5 1 1/9; ...
     4 1 1 1 1/3 4 1/4; ... 
     4 1 1 1 1/3 4 1/4; ... 
     4 1 1 1 1/3 4 1/4; ...
     5 3 3 3 1 5 1/4; ...
     1 1/4 1/4 1/4 1/5 1 1/9; ... 
     9 4 4 4 4 9 1];
[x,lamda] = eig(A);
lamda_max = max(max(lamda));   %得到最大特征值
[s,t] = find(lamda==lamda_max);  
x_max = x(:,t);                %得到最大特征向量
n = length(x_max);  
for i=1:n
    x_1(i) = x_max(i)/sum(x_max);  %正规化特征向量
end
W = x_1;
%% 对于7个因素 12个典型区域的比较
% 对于小区环境 12个地区相互的对比
load Community.mat
% 对于 商业 相互的对比
load Business.mat
% 对于 医疗  12个小区的对比
load Medical.mat
% 对于 交通  12个小区的对比
load traffic_weight.mat
% 对于 教育  12个小区的对比
load education_weight.mat
% 对于周边环境 12个地区的比较
load environment_weight.mat
% 对于 经济负担 12个地区的比较
load price.mat % 房子按照100平米计算, 按揭8成, 20年还清
huankuan = [3664 4188 3403 3403 7329 8900 12565 19371 6282 12041 23559 4502];
burden = huankuan/7000;
burden_weight = burden/sum(burden);
%% 整理 最后的结果
% 最后对12个小区打分
load L_W.mat
score=L_W*[Community;Business;Medical;traffic_weight;education_weight;environment_weight;-burden_weight];
% 映射至 1-5 标度
max_score=max(score);
min_score=min(score);
level = 4/(max_score-min_score)*score + 5 - 4/(max_score-min_score)*max_score;
level = round(level);