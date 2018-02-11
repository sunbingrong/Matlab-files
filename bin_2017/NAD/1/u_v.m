%%
x=stdout(:,1);
y=stdout(:,5);
plot(x,y)
%%
load h.mat
h(h~=0)  = h(h~=0)-500;
lon=-100:5/12:30;
lat=-5/12:5/12:66.5;
m_proj('miller','lon',[-100 40],'lat',[0 66.5]);
m_contourf(lon,lat,h','linestyle','none');
m_grid('linestyle','none');
colorbar
axis image
%%
u1=zeros(size(u));
v1=zeros(size(v));
u1(1:3:313,1:4:161)=u(1:3:313,1:4:161);
v1(1:3:313,1:4:161)=v(1:3:313,1:4:161);
contourf(topo_NA)
hold on
quiver(u1',v1',6)
set(gca,'xtick',[1:60:300])
set(gca,'xticklabel',{'100буW','75буW','50буW','25буW','0бу'})
set(gca,'ytick',[1:35:150])
set(gca,'yticklabel',{'0бу','15буN','30буN','45буN','60буN'})


