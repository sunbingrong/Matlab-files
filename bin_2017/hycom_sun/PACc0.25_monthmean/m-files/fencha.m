clear;clc
data.lon = load('../Input/hycom.plon');
data.lat  = load('../Input/hycom.plat');

load map3.mat

lon = data.lon(1,:);
lat  = flipud(data.lat(:,1));
m   =  length(lon);
n    =  length(lat);
a = find(lon ==126);
b = find(lat >=10 & lat <=18);

for year = 1:10
    subplot(3,4,year);
    for month = 1:12
        v = load(['../Input/01-19v3d.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        v(abs(v)>=2)= nan;
        topo = ones(n,m);
        topo(isnan(v)) = 0;
        H = load(['../Input/01-19thknss3d.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        H(H == -999.9) = nan;
        H(H>=1000) = nan;
        H(isnan(v)) = 0;
        v(isnan(v))  = 0;
        topo = flipud(topo)';
        vv = flipud(v)';
        bifur(year,month) = lat(round(bifurcation_NPacific(a,b,vv,topo,8)));
    end
    year
    plot([1:12],bifur(year,:),'-bo','LineWidth',1.5)
end
%bifurcation = mean(bifur(2:10,:),1);
bifurcation = mean([bifur(1,:); bifur(5,:)],1);
NBL_150E = smooth(bifurcation,3);
save('../Output/NBL_150E.mat','NBL_150E');
%% V & H ±≥æ∞≥°
clear;clc
load mycolor.mat
for year = 1
    for month =5
        v = load(['../Input/01-19v3d.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        v(abs(v)>=3)= nan;
        H = load(['../Input/01-19thknss3d.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        H(H == -999.9) = nan;
        H(H>=1000) = nan;
    end
end
vv  = flipud(v);
HH= flipud(H);
contourf(vv)
colormap(mycolor);
%% bifurcation ª≠Õº
figure
load('../Output/bifurcation.mat');
plot([1:12],bifurcation,'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°„N)');