clear;clc
lon = importdata('../Output/longitude.mat');
lat  = importdata('../Output/latitude.mat');

load map3.mat

m   =  length(lon);
n    =  length(lat);
a = find(lon ==128.25);
b = find(lat >=10 & lat <=18);

v_mean = importdata('../Output/v_mean.mat');
for month = 1:12
    v = v_mean(:,:,month);
    v(abs(v)>=3) = nan;
    topo = ones(m,n);
    topo(isnan(v)) = 0;
    v(isnan(v))  = 0;
    bifur(month) = lat(round(bifurcation_NPacific(a,b,v,topo,10)));
end
%% bifurcation ª≠Õº
mean_bifur = smooth(bifur);
%plot([1:12],c,'-bo','LineWidth',1.5)
plot([1:12],smooth(mean_bifur),'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°„N)');
NBL_Ctrl = mean_bifur;
save('../Output/NBL_Ctrl.mat','NBL_Ctrl');