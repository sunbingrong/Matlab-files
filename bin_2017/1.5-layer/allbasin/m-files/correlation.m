%% 计算每个敏感性实验与基本实验的相关系数
load('../Output/All_latitude.mat');
[m,n] = size(All_latitude);
cor=zeros(1,length(m-1));
for i = 1:m-1
    cor(i) = min(min(corrcoef(All_latitude(end,:), All_latitude(i+1,:))));
end

x=1:m-1;
plot(x,cor,'-ro','LineWidth',1)
xlim([1,m-1])
hold on
ylabel('Correlation');
set(gca,'XTick',1:m-1);
set(gca,'XTickLabel',{'140E','150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W'});
%% S评分
% S = 1 ? <(NBL(Ctrl) ? NBL(Sen))^2>/<NBL(Sen)^2>
load('../Output/All_latitude.mat');
[m,n] = size(All_latitude);
diff = zeros(1,m-1);
control = zeros(1,m-1);
for i = 1:m-1
    for j = 1:n
        control(i) = control(i) + All_latitude(end,j)^2;
        diff(i) = diff(i) + (All_latitude(i,j)-All_latitude(end,j))^2; 
    end
    s(i) = 1 - diff(i)./control(i);
end