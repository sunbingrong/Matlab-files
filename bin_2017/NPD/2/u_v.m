%%
x=stdout(:,1);
y=stdout(:,5);
plot(x,y)
%% 
clear
load h.mat
h(h~=0)  = h(h~=0)-500;
lon=100:1/6:220;
lat=0:1/6:40;
m_proj('miller','lon',[100 220],'lat',[0 40]);
m_contourf(lon,lat,h','linestyle','none');
m_grid('linestyle','none');
colorbar
%%
u1=zeros(size(u));
v1=zeros(size(v));
u1(1:6:721,1:3:241)=u(1:6:721,1:3:241);
v1(1:6:721,1:3:241)=v(1:6:721,1:3:241);
contourf(topo_NPC)
hold on
quiver(u1',v1',6)
set(gca,'xtick',[1:140:700])
set(gca,'xticklabel',{'100°„E','125°„E','150°„E','175°„E','160°„W'})
set(gca,'ytick',[1:48:240])
set(gca,'yticklabel',{'0°„','8°„N','16°„N','24°„N','32°„N'})
f = getframe(gca);
image = frame2im(f);
imwrite(image,'1.png')






