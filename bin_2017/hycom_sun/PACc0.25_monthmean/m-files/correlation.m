% 计算每个敏感性实验与基本实验的相关系数
% S评分
% S = 1 - <(NBL(Ctrl) - NBL(Sen))^2>/<NBL(Ctrl)^2>, <>代表时间平均
%% NBL S评分
clear;clc;
NBL_Ctrl = importdata('../Output/NBL_Ctrl.mat');
NBL_Sen = importdata('../Output/NBL_Sen.mat');
[m,n] = size(NBL_Sen);
diff = zeros(1,m);
for i = 1:m
    control = mean(NBL_Ctrl.^2);
    diff(i) = mean((NBL_Ctrl-NBL_Sen(i,:)).^2);
    s(i) = 1 - diff(i)./control;
end
plot(1:m,s,'-bo','LineWidth',1.5)
xlim([1,m])
set(gca,'XTick',1:m);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W'});
%% 18N Kurosio Transport
clear;clc;
KC_Ctrl = importdata('../Output/18N_Trans_Ctrl.mat');
KC_Sen = importdata('../Output/18N_Trans_Sen.mat');
[m,n] = size(KC_Sen);
diff = zeros(1,m);
for i = 1:m
    control = mean(KC_Ctrl.^2);
    diff(i) = mean((KC_Ctrl-KC_Sen(i,:)).^2);
    s(i) = 1 - diff(i)./control;
end
plot(1:m,s,'-bo','LineWidth',2)
xlim([1,m])
set(gca,'XTick',1:m);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W'});
title('S Score of Sensitive Cases on KC Transport')
%% 8N Mindanao Current Seasonal Transport S 评分
clear;clc;
MC_Ctrl = importdata('../Output/8N_Trans_Ctrl.mat');
MC_Sen = importdata('../Output/8N_Trans_Sen.mat');
[m,n] = size(MC_Sen);
diff = zeros(1,m);
for i = 1:m
    control = mean(MC_Ctrl.^2);
    diff(i) = mean((MC_Ctrl-MC_Sen(i,:)).^2);
    s(i) = 1 - diff(i)./control;
end
plot(1:m,s,'-bo','LineWidth',2)
xlim([1,m])
set(gca,'XTick',1:m);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W'});
title('S Score of Sensitive Cases on MC Transport')