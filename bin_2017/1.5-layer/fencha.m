%% 地形
contourf(case2_NPC)
hold on
set(gca,'ytick',[1:60:241])
set(gca,'yticklabel',{'0°','10°N','20°N','30°N','40°N'})
set(gca,'xtick',[1:80:321])
set(gca,'xticklabel',{'100°E','120°E','140°E','160°E','180°E'})
f = getframe(gca);
image = frame2im(f);
%imwrite(image,'1.png')
%% Introduction
% basic：100E-70w 月平均的风吹出来的bifurcation，并产生180E,150E处的边界条件
% case1：100E-180E 内区同样的风吹出来的
% case2：100E-150E，同case1
% case3：100E-150E ，边界条件提前了一个月的相位
%第一列为4点，第二列为8点，第三列为12点
%% basic实验，计算气候态的分叉点位置
load Test_case140E_bifur_PHI.dat
basic_bifur = Test_case140E_bifur_PHI(3601:end,2);
a=reshape(basic_bifur,[30,12,10]);
b=sum(a,3)/10;
c=sum(b)/30;
plot(c,'-bo')
xlim([1,12]);
%% case1实验
load case1_bifur_PHI.dat
case1_bifur = case1_bifur_PHI(3601:end,2);
a=reshape(case1_bifur,[30,12,10]);
b=sum(a,3)/10;
c=sum(b)/30;
plot(c,'-bo')
xlim([1,12]);
%% case2实验
load case2_bifur_PHI.dat
case2_bifur = case2_bifur_PHI(3601:end,2);
a=reshape(case2_bifur,[30,12,10]);
b=sum(a,3)/10;
c=sum(b)/30;
plot(c,'-bo')
xlim([1,12]);
%% case3实验
load case180E_bifur_PHI.dat
case180E_bifur = case180E_bifur_PHI(3601:end,2);
a=reshape(case180E_bifur,[30,12,10]);
b=sum(a,3)/10;
c=sum(b)/30;
plot(c,'-bo')
xlim([1,12]);
%% bifur画图
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°N)');