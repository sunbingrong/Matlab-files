clear;clc
% sigma :lon*lat*time*depth
% u & v :lon*lat*time*depth
% read all the data
load('../Output/longitude.mat'); load('../Output/latitude.mat'); load('../Output/depth.mat');
load map3.mat;

x1=1:18;
y1=1:3;
[X1,Y1]=meshgrid(x1,y1);
x2=linspace(1,18,54);
[X,Y]=meshgrid(x2,1:3);
map3_1 = griddata(X1',Y1',map3,X',Y');
w = ncread('../Input/SODA_2.2.4_201001.cdf','W');
% calculate the soda_bc
%calculate the h_depth
nx = length(lon); ny = length(lat); nt = 12; nz = length(depth);
% calculate the u/v
contourf(mean(w(250:500,100:300,1:9),3)')
%contourf(mean(w(:,:,1:9),3)')
caxis([-1 1]*1e-5)
colormap(map3_1)
%%
[glon,glat]=meshgrid(lon,lat);
j=1;
figure(j);
m_proj('miller','lon',[100 290],'lat',[-20 60])
%   m_proj('miller','lon',rangelon,'lat',rangelat)
hold on;
m_contourf(glon,glat,mean(w(:,:,1:9),3)','linestyle','none');
%clabel(c,h,'fontsize',14,'color','k','fontweight','bold')
%     pcolor(glon,glat,double(ww));
m_coast('patch',[110 110 110] / 255);
colormap(map3)
m_grid('linestyle','none','box','on','tickdir','out');
h = colorbar;
set(get(h,'ylabel'),'String','zonal velocity(m/s)');
caxis([-2*1e-4,2*1e-4]);
title(['zonal velocity ' 'z=' num2str(depth(j)) 'm'],'FontSize',10);
cmocean('balance','pivot',0) 
