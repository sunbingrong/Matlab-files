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
% case1：100E-70w 真实风吹出来的bifurcation，产生180E的初始状态
% case2：100E-180E 真实的风吹出来的，边界是case1算出来的
% case3：同case1，产生150E处的初始状态
% case4：100E-150E 出来的bifurcation
% change150E_phase_bifur_PHI.dat 提前了一个月的相位
%%
%1974.1.1-2014.1.1的分叉点数据
%第一列为4点，第二列为8点，第三列为12点
%存储每个月天数的数组,从1月开始
%12代表12个月，38列代表每一年1974-2002
load case1_bifur_PHI.dat
load case2_bifur_PHI.dat
load case7_bifur_PHI.dat
load case3_bifur_PHI.dat
load change150E_phase_bifur_PHI.dat
load change180E_phase_bifur_PHI.dat
case1_monmean=zeros(12,40);  %每个月存一个数值
case2_monmean=zeros(12,40);
case7_monmean=zeros(12,40);
case3_monmean=zeros(12,40);
phase150 = zeros(12,40);
phase180 = zeros(12,40);
% case3_monmean=zeros(12,40);
% case4_monmean=zeros(12,40);
% case5_monmean=zeros(12,40);
% case6_monmean=zeros(12,40);
bifur_PHI1=case1_bifur_PHI(:,3);
bifur_PHI2=case2_bifur_PHI(:,3);
bifur_PHI7=case7_bifur_PHI(:,3);
bifur_PHI3=case3_bifur_PHI(:,3);
bifur_phase150 = change150E_phase_bifur_PHI(:,2);
bifur_phase180 = change180E_phase_bifur_PHI(:,3);
% bifur_PHI3=case3_bifur_PHI(:,2);
% bifur_PHI4=case4_bifur_PHI(:,2);
% bifur_PHI5=case5_bifur_PHI(:,2);
% bifur_PHI6=case1_bifur_PHI_dx(:,3);
%%
nday=[31 28 31 30 31 30 31 31 30 31 30 31];
day1=1;
n=1;
for year=1974:2013
    if mod(year,4)==0
        nday(2)=29;
    end
    for j=1:12
        m=mod(n,12);
        if mod(n,12)==0
            m=12;
        end
        phase180(j,year-1973)=sum(bifur_phase180(day1:day1-1+nday(m)))/nday(m);
        day1=day1+nday(m);
        n=n+1;
    end
end
%% case2,3,4,5
for i=1:12
  a(i)=sum(phase180(i,30:39))/10;
end
plot([1:24],[a a],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°N)');
%%
A_monmean=zeros(12,40);
nday=[31 28 31 30 31 30 31 31 30 31 30 31];
day1=1;
n=1;
for year=1974:2013
    if mod(year,4)==0
        nday(2)=29;
    end
    for j=1:12
        m=mod(n,12);
        if mod(n,12)==0
            m=12;
        end
        A_monmean(j,year-1973)=sum(A(day1:day1-1+nday(m)))/nday(m);
        day1=day1+nday(m);
        n=n+1;
    end
end