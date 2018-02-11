%% PACa0.25  Climatology SST 

clear;clc
data.lon = load('../Input/hycom.plon');
data.lat  = load('../Input/hycom.plat');

load map3.mat

lon = data.lon(1,:);
lat  = flipud(data.lat(:,1));
m   =  length(lon);
n    =  length(lat);
a = find(lon >=119.75 & lon<=289.75);
b = find(lat >=-0.125 & lat <=34.125);

k = 0;
sst_total = zeros(n,m);
for year = 1:10
    for month = 1:12
        sst = load(['../Input/sst.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        sst(sst == -999.9) = nan;
        %H(H>=1000) = nan;
        %H(isnan(v)) = 0;
        %v(isnan(v))  = 0;
        %vv = flipud(v)';
        %HH = flipud(H)';
        %a1 = HH(a,b);
        %a2 = vv(a,b);
        sst_total = sst_total + sst;
        k = k +1;
    end
    year
end
sst_all = flipud(sst_total)';
sst_all = sst_all/k;
lon_Pac = lon(a(1):a(end));
lat_Pac = lat(b(1):b(end));
PACa_SST_Clima = sst_all(a,b);
[X,Y]=meshgrid(lon_Pac,lat_Pac);
%m_proj('Equidistant Cylindrical','lon',[lon_Pac(1) lon_Pac(end)],'lat',[lat_Pac(1) lat_Pac(end)]);
m_proj('miller','lon',[120 290],'lat',[0 35]);
%m_proj('Mercator','lon',[lon_Pac(1) lon_Pac(end)],'lat',[lat_Pac(1) lat_Pac(end)]);
m_coast('patch',[.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',3);
%m_grid('linestyle','none','fontsize',15);
m_grid('linestyle','none','box','fancy','tickdir','in','fontsize',14);
hold on
[c,h] = m_contourf(X,Y,PACa_SST_Clima');
%set(gca,'box','on')
%set(h,'ShowText','on','labelspacing',600)
%clabel(c,h,'fontsize',15,'color','k','rotation',0,'fontweight','bold')
%m_grid('box','fancy','tickdir','out','linestyle','none','fontsize',15);
clabel(c,h,'manual','fontsize',12,'color','k','rotation',0,'fontweight','bold')
%colormap(map3);
save('../Output/PACa_SST_Clima.mat','PACa_SST_Clima');
%% PACa0.25  Climatology SSS

clear;clc
data.lon = load('../Input/hycom.plon');
data.lat  = load('../Input/hycom.plat');

load map3.mat

lon = data.lon(1,:);
lat  = flipud(data.lat(:,1));
m   =  length(lon);
n    =  length(lat);
a = find(lon >=119.75 & lon<=289.75);
b = find(lat >=-0.125 & lat <=34.125);

k = 0;
sss_total = zeros(n,m);
for year = 1:10
    for month = 1:12
        sss = load(['../Input/sss.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        sss(sss == -999.9) = nan;
        %H(H>=1000) = nan;
        %H(isnan(v)) = 0;
        %v(isnan(v))  = 0;
        %vv = flipud(v)';
        %HH = flipud(H)';
        %a1 = HH(a,b);
        %a2 = vv(a,b);
        sss_total = sss_total + sss;
        k = k +1;
    end
    year
end
sss_all = flipud(sss_total)';
sss_all = sss_all/k;
lon_Pac = lon(a(1):a(end));
lat_Pac = lat(b(1):b(end));
PACa_SSS_Clima = sss_all(a,b);
[X,Y]=meshgrid(lon_Pac,lat_Pac);
%m_proj('Equidistant Cylindrical','lon',[lon_Pac(1) lon_Pac(end)],'lat',[lat_Pac(1) lat_Pac(end)]);
m_proj('miller','lon',[120 290],'lat',[0 35]);
%m_proj('Mercator','lon',[lon_Pac(1) lon_Pac(end)],'lat',[lat_Pac(1) lat_Pac(end)]);
m_coast('patch',[.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',3);
%m_grid('linestyle','none','fontsize',15);
m_grid('linestyle','none','box','fancy','tickdir','in','fontsize',14);
hold on
[c,h] = m_contourf(X,Y,PACa_SSS_Clima');
%set(gca,'box','on')
%set(h,'ShowText','on','labelspacing',600)
%clabel(c,h,'fontsize',15,'color','k','rotation',0,'fontweight','bold')
%m_grid('box','fancy','tickdir','out','linestyle','none','fontsize',15);
clabel(c,h,'manual','fontsize',12,'color','k','rotation',0,'fontweight','bold')
%colormap(map3);
save('../Output/PACa_SSS_Clima.mat','PACa_SSS_Clima');