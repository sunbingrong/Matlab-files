clear;clc
data.lon = load('../Input/hycom.plon');
data.lat  = load('../Input/hycom.plat');

lon = data.lon(1,:);
lat  = flipud(data.lat(:,1));
m   =  length(lon);
n    =  length(lat);
a = find(lon ==128);
b = find(lat >=10 & lat <=18);

for year = 1:10
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
end
%save('../Output/bifurcation.mat','bifur');
%% bifurcation »­Í¼
figure
c = mean(bifur(1:10,:),1);
bifurcation = c;
%bifurcation = smooth(c,3);
plot([1:12],bifurcation,'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(¡ãN)');
save('../Output/bifurcation.mat','bifurcation');
%% V & H ±³¾°³¡
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