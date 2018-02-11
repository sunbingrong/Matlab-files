% 计算每个敏感性实验与基本实验的相关系数
load('all_latitude.mat');
[s,~] = size(C);
cor=zeros(1,length(s-1));
for i = 1:s-1
    cor(i) = min(min(corrcoef(C(1,:), C(i+1,:))));
end

    x=1:12;
    plot(x,cor,'-ro','LineWidth',1)
    xlim([1,12])
    hold on
    ylabel('Correlation');
    set(gca,'XTick',1:12);
    set(gca,'XTickLabel',{'140E','150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W'});