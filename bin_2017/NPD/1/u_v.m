%% 
load h.mat
h(h~=0)  = h(h~=0)-500;
lon=100:1/6:220;
lat=0:1/6:40;
m_proj('miller','lon',[100 220],'lat',[0 40]);
m_contourf(lon,lat,h','linestyle','none');
m_grid('linestyle','none');
colorbar
%%
clear
load h.mat
h(h~=0)  = h(h~=0)-500;
mesh(h')
view([0,90])
axis image
colorbar




