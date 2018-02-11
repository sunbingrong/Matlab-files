% Calculate Climatology SST
% 2003 - 2013 Global Data
clc; clear;
MOI_SST_2002_2013 = importdata('../Output/MOI_SST_2002_2013.mat');
lon = importdata('../Output/MOI_SST_lon.mat');
lat  = importdata('../Output/MOI_SST_lat.mat');

lon_f = find(lon==119.875);  lon_l = find(lon==289.875);
lat_f  = find(lat==-0.125);  lat_l  = find(lat ==34.125);
Pac_SST_MOI_Clima = nanmean(MOI_SST_2002_2013(lon_f:lon_l,lat_f:lat_l,2:end),3);
Pac_SST_MOI_Clima(abs(Pac_SST_MOI_Clima)>=50)=nan;
lon_Pac = lon(lon_f:lon_l);
lat_Pac = lat(lat_f:lat_l);
[X,Y]=meshgrid(lon_Pac,lat_Pac);
%m_proj('Equidistant Cylindrical','lon',[lon_Pac(1) lon_Pac(end)],'lat',[lat_Pac(1) lat_Pac(end)]);
m_proj('miller','lon',[120 290],'lat',[0 35]);
%m_proj('Mercator','lon',[lon_Pac(1) lon_Pac(end)],'lat',[lat_Pac(1) lat_Pac(end)]);
m_coast('patch',[.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',3);
%m_grid('linestyle','none','fontsize',15);
m_grid('box','fancy','tickdir','in','fontsize',15);
hold on
[c,h] = m_contourf(X,Y,Pac_SST_MOI_Clima');
set(gca,'box','on')
%set(h,'ShowText','on','labelspacing',800)
%m_grid('box','fancy','tickdir','out','linestyle','none','fontsize',15);
%clabel(c,h,'manual','fontsize',14,'color','k','rotation',0,'fontweight','bold')
%colormap(map3);
save('../Output/Pac_SST_MOI_Clima.mat','Pac_SST_MOI_Clima');