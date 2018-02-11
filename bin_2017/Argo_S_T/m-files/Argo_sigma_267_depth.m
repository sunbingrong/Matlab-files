clear;
lon       =  ncread('Clima_Density_ArgoData.nc','LONGITUDE');
lat        =  ncread('Clima_Density_ArgoData.nc','LATITUDE');
depth  =  ncread('Clima_Density_ArgoData.nc','DEP');
Level   = ncread('Clima_Density_ArgoData.nc','LEVEL');
lon = double(lon); lat = double(lat); Level = double(Level);
% 最接近26.7的LEVEL
sigma267_level = find(abs(Level-26.7)<0.01);
lon_f = find(lon==119.5);  lon_l = find(lon==289.5);
lat_f  = find(lat==-0.5);  lat_l  = find(lat ==34.5);
Pac_sigma267_depth = depth(lon_f:lon_l,lat_f:lat_l,sigma267_level);

lon_Pac = lon(lon_f):lon(lon_l);
lat_Pac = lat(lat_f):lat(lat_l);
[X,Y]=meshgrid(lon_Pac,lat_Pac);
%m_proj('Equidistant Cylindrical','lon',[lon_Pac(1) lon_Pac(end)],'lat',[lat_Pac(1) lat_Pac(end)]);
m_proj('miller','lon',[120 290],'lat',[0 35]);
%m_proj('Mercator','lon',[lon_Pac(1) lon_Pac(end)],'lat',[lat_Pac(1) lat_Pac(end)]);
m_coast('patch',[.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',3);
%m_grid('linestyle','none','fontsize',12);
m_grid('linestyle','none','box','fancy','tickdir','in','fontsize',14);
%m_grid('box','fancy','tickdir','in','fontsize',13);
hold on
[c,h] = m_contourf(X,Y,Pac_sigma267_depth');
%set(gca,'box','on')
%set(h,'ShowText','on','labelspacing',800)
%hold off
%m_grid('box','fancy','tickdir','out','linestyle','none','fontsize',15);
%scrsz = get(0,'ScreenSize');
%set(gcf,'Position',scrsz);
%set(gcf, 'PaperPositionMode', 'auto')
clabel(c,h,'manual','fontsize',14,'color','k','rotation',0,'fontweight','bold')
%colormap(map3);
%saveas(gcf,['../Output/',num2str(EB),'E_h.jpg']);