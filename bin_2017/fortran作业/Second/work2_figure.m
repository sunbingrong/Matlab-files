%% grid_ua, grid_va
data_u1 = load('grid_ua.txt');
data_v1 = load('grid_va.txt');
data_u=data_u1(1:5:111,1:4:116);
data_v=data_v1(1:5:111,1:4:116);
x=117:0.1:128.5;
y=30:0.1:41.0;
clear lon lat
[lon lat]=meshgrid(x,y);
vec(:,:)=sqrt(data_u1.^2+data_v1.^2);
vec(100:105,1:27)=NaN;
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
m_contourf(lon,lat,vec,50,'k','edgecolor','none');
hold on
clear lon lat x y
x=117:0.4:128.5;
y=30:0.5:41.0;
[lon lat]=meshgrid(x,y);
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
data_u(21:23,1:8)=NaN;
data_v(21:23,1:8)=NaN;
data_u(21,3)=10;
data_v(21,3)=0;
%m_vec(.05,lon,lat,data_u,data_v,'headangle',55,'headlength',4.,'shaftwidth',0.8)
m_quiver(lon,lat,data_u,data_v,1.5,'color',[0 0 0],'LineWidth',1.2)
hold on
m_coast('color',[0 0 0]','linewidth',2.)
hold on
m_grid('linestyle','none','tickdir','out','linewidth',1.2,'fontsize',16);
m_text(117.5,40.3,'10m/s','fontsize',14)
colorbar
caxis([0 12])
h=colorbar;
set(h,'fontsize',15,'YTick',[0:2:12])
set(get(h,'Title'),'string','m/s ','fontsize',15);
title('10m Wind of guess at 2010-05-29-12','fontsize',18,'color','k')
print('-dpdf','C:\Users\ouc-ice\Desktop\homework2\Output\grid_ua_org')

%%  ua,va
clear
clf
data_u1 = load('successive_ua.txt');
data_v1 = load('successive_va.txt');

data_u=data_u1(1:5:111,1:4:116);
data_v=data_v1(1:5:111,1:4:116);
x=117:0.1:128.5;
y=30:0.1:41.0;
clear lon lat
[lon lat]=meshgrid(x,y);
vec(:,:)=sqrt(data_u1.^2+data_v1.^2);
for ii=5:111-4
    for jj=5:116-4
        vec(ii,jj,:)=nanmean(nanmean(vec(ii-4:ii+4,jj-4:jj+4,:),1),2);
    end
end
for ii=2:111-1
    for jj=2:116-1
        vec(ii,jj,:)=nanmean(nanmean(vec(ii-1:ii+1,jj-1:jj+1,:),1),2);
    end
end
vec(100:105,1:27)=NaN;
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
m_contourf(lon,lat,vec,50,'k','edgecolor','none');
hold on
clear lon lat x y
x=117:0.4:128.5;
y=30:0.5:41.0;
[lon lat]=meshgrid(x,y);
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
data_u(21:23,1:8)=NaN;
data_v(21:23,1:8)=NaN;
data_u(21,3)=10;
data_v(21,3)=0;
%m_vec(.05,lon,lat,data_u,data_v,'headangle',55,'headlength',4.,'shaftwidth',0.8)
m_quiver(lon,lat,data_u,data_v,1.5,'color',[0 0 0],'LineWidth',1.2)
hold on
m_coast('color',[0 0 0]','linewidth',2.)
hold on
m_grid('linestyle','none','tickdir','out','linewidth',1.2,'fontsize',16);
m_text(117.5,40.3,'10m/s','fontsize',14)
colorbar
caxis([0 12])
h=colorbar;
set(h,'fontsize',15,'YTick',[0:2:12])
set(get(h,'Title'),'string','m/s ','fontsize',15);
title('10m Wind of SC at 2010-05-29-12','fontsize',18,'color','k')
print('-dpdf','C:\Users\ouc-ice\Desktop\homework2\Output\figure_ua_res')

%% grid_ub grid_vb
clc
clf
clear
data_u1 = load('grid_ub.txt');
data_v1 = load('grid_vb.txt');

data_u=data_u1(1:5:111,1:4:116);
data_v=data_v1(1:5:111,1:4:116);
x=117:0.1:128.5;
y=30:0.1:41.0;
clear lon lat
[lon lat]=meshgrid(x,y);
vec(:,:)=sqrt(data_u1.^2+data_v1.^2);
vec(100:105,1:27)=NaN;
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
m_contourf(lon,lat,vec,50,'k','edgecolor','none');
hold on
clear lon lat x y
x=117:0.4:128.5;
y=30:0.5:41.0;
[lon lat]=meshgrid(x,y);
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
data_u(21:23,1:8)=NaN;
data_v(21:23,1:8)=NaN;
data_u(21,3)=10;
data_v(21,3)=0;
%m_vec(.05,lon,lat,data_u,data_v,'headangle',55,'headlength',4.,'shaftwidth',0.8)
m_quiver(lon,lat,data_u,data_v,1.5,'color',[0 0 0],'LineWidth',1.2)
hold on
m_coast('color',[0 0 0]','linewidth',2.)
hold on
m_grid('linestyle','none','tickdir','out','linewidth',1.2,'fontsize',16);
m_text(117.5,40.3,'10m/s','fontsize',14)
colorbar
caxis([0 12])
h=colorbar;
set(h,'fontsize',15,'YTick',[0:2:12])
set(get(h,'Title'),'string','m/s ','fontsize',15);
title('10m Wind of guess at 2010-05-29-15','fontsize',18,'color','k')
print('-dpdf','C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\figure_ub_org')

%% ub,vb
clear
clf
data_u1 = load('successive_ub.txt');
data_v1 = load('successive_vb.txt');

data_u=data_u1(1:5:111,1:4:116);
data_v=data_v1(1:5:111,1:4:116);
x=117:0.1:128.5;
y=30:0.1:41.0;
clear lon lat
[lon lat]=meshgrid(x,y);
vec(:,:)=sqrt(data_u1.^2+data_v1.^2);
for ii=5:111-4
    for jj=5:116-4
        vec(ii,jj,:)=nanmean(nanmean(vec(ii-4:ii+4,jj-4:jj+4,:),1),2);
    end
end
for ii=2:111-1
    for jj=2:116-1
        vec(ii,jj,:)=nanmean(nanmean(vec(ii-1:ii+1,jj-1:jj+1,:),1),2);
    end
end
vec(100:105,1:27)=NaN;
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
m_contourf(lon,lat,vec,50,'k','edgecolor','none');
hold on
clear lon lat x y
x=117:0.4:128.5;
y=30:0.5:41.0;
[lon lat]=meshgrid(x,y);
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
data_u(21:23,1:8)=NaN;
data_v(21:23,1:8)=NaN;
data_u(21,3)=10;
data_v(21,3)=0;
%m_vec(.05,lon,lat,data_u,data_v,'headangle',55,'headlength',4.,'shaftwidth',0.8)
m_quiver(lon,lat,data_u,data_v,1.5,'color',[0 0 0],'LineWidth',1.2)
hold on
m_coast('color',[0 0 0]','linewidth',2.)
hold on
m_grid('linestyle','none','tickdir','out','linewidth',1.2,'fontsize',16);
m_text(117.5,40.3,'10m/s','fontsize',14)
colorbar
caxis([0 12])
h=colorbar;
set(h,'fontsize',15,'YTick',[0:2:12])
set(get(h,'Title'),'string','m/s ','fontsize',15);
title('10m Wind of guess at 2010-05-29-15','fontsize',18,'color','k')
print('-dpdf','C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\figure_ub_res')

%% grid_uc ,grid_vc
clear
clc
clf
data_u1=importdata('C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\grid_uc.txt');
data_v1=importdata('C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\grid_vc.txt');

data_u=data_u1(1:5:111,1:4:116);
data_v=data_v1(1:5:111,1:4:116);
x=117:0.1:128.5;
y=30:0.1:41.0;
clear lon lat
[lon lat]=meshgrid(x,y);
vec(:,:)=sqrt(data_u1.^2+data_v1.^2);
vec(100:105,1:27)=NaN;
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
m_contourf(lon,lat,vec,50,'k','edgecolor','none');
hold on
clear lon lat x y
x=117:0.4:128.5;
y=30:0.5:41.0;
[lon lat]=meshgrid(x,y);
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
data_u(21:23,1:8)=NaN;
data_v(21:23,1:8)=NaN;
data_u(21,3)=10;
data_v(21,3)=0;
%m_vec(.05,lon,lat,data_u,data_v,'headangle',55,'headlength',4.,'shaftwidth',0.8)
m_quiver(lon,lat,data_u,data_v,1.5,'color',[0 0 0],'LineWidth',1.2)
hold on
m_coast('color',[0 0 0]','linewidth',2.)
hold on
m_grid('linestyle','none','tickdir','out','linewidth',1.2,'fontsize',16);
m_text(117.5,40.3,'10m/s','fontsize',14)
colorbar
caxis([0 12])
h=colorbar;
set(h,'fontsize',15,'YTick',[0:2:12])
set(get(h,'Title'),'string','m/s ','fontsize',15);
title('10m Wind of guess at 2010-05-29-18','fontsize',18,'color','k')
print('-dpdf','C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\figure_uc_org')

%% uc,vc
clear
clf
data_u1=importdata('C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\successive_uc.txt');
data_v1=importdata('C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\successive_vc.txt');

data_u=data_u1(1:5:111,1:4:116);
data_v=data_v1(1:5:111,1:4:116);
x=117:0.1:128.5;
y=30:0.1:41.0;
clear lon lat
[lon lat]=meshgrid(x,y);
vec(:,:)=sqrt(data_u1.^2+data_v1.^2);
for ii=5:111-4
    for jj=5:116-4
        vec(ii,jj,:)=nanmean(nanmean(vec(ii-4:ii+4,jj-4:jj+4,:),1),2);
    end
end
for ii=2:111-1
    for jj=2:116-1
        vec(ii,jj,:)=nanmean(nanmean(vec(ii-1:ii+1,jj-1:jj+1,:),1),2);
    end
end
vec(100:105,1:27)=NaN;
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
m_contourf(lon,lat,vec,50,'k','edgecolor','none');
hold on
clear lon lat x y
x=117:0.4:128.5;
y=30:0.5:41.0;
[lon lat]=meshgrid(x,y);
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
data_u(21:23,1:8)=NaN;
data_v(21:23,1:8)=NaN;
data_u(21,3)=10;
data_v(21,3)=0;
%m_vec(.05,lon,lat,data_u,data_v,'headangle',55,'headlength',4.,'shaftwidth',0.8)
m_quiver(lon,lat,data_u,data_v,1.5,'color',[0 0 0],'LineWidth',1.2)
hold on
m_coast('color',[0 0 0]','linewidth',2.)
hold on
m_grid('linestyle','none','tickdir','out','linewidth',1.2,'fontsize',16);
m_text(117.5,40.3,'10m/s','fontsize',14)
colorbar
caxis([0 12])
h=colorbar;
set(h,'fontsize',15,'YTick',[0:2:12])
set(get(h,'Title'),'string','m/s ','fontsize',15);
title('10m Wind of guess at 2010-05-29-18','fontsize',18,'color','k')
print('-dpdf','C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\figure_uc_res')

%% grid_ud, grid_vd
clear
clc
clf
data_u1=importdata('C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\grid_ud.txt');
data_v1=importdata('C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\grid_vd.txt');

data_u=data_u1(1:5:111,1:4:116);
data_v=data_v1(1:5:111,1:4:116);
x=117:0.1:128.5;
y=30:0.1:41.0;
clear lon lat
[lon lat]=meshgrid(x,y);
vec(:,:)=sqrt(data_u1.^2+data_v1.^2);
vec(100:105,1:27)=NaN;
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
m_contourf(lon,lat,vec,50,'k','edgecolor','none');
hold on
clear lon lat x y
x=117:0.4:128.5;
y=30:0.5:41.0;
[lon lat]=meshgrid(x,y);
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
data_u(21:23,1:8)=NaN;
data_v(21:23,1:8)=NaN;
data_u(21,3)=10;
data_v(21,3)=0;
%m_vec(.05,lon,lat,data_u,data_v,'headangle',55,'headlength',4.,'shaftwidth',0.8)
m_quiver(lon,lat,data_u,data_v,1.5,'color',[0 0 0],'LineWidth',1.2)
hold on
m_coast('color',[0 0 0]','linewidth',2.)
hold on
m_grid('linestyle','none','tickdir','out','linewidth',1.2,'fontsize',16);
m_text(117.5,40.3,'10m/s','fontsize',14)
colorbar
caxis([0 12])
h=colorbar;
set(h,'fontsize',15,'YTick',[0:2:12])
set(get(h,'Title'),'string','m/s ','fontsize',15);
title('10m Wind of guess at 2010-05-29-21','fontsize',18,'color','k')
print('-dpdf','C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\figure_ud_org')

%% ud,vd
clear
clf
data_u1=importdata('C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\successive_ud.txt');
data_v1=importdata('C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\successive_vd.txt');

data_u=data_u1(1:5:111,1:4:116);
data_v=data_v1(1:5:111,1:4:116);
x=117:0.1:128.5;
y=30:0.1:41.0;
clear lon lat
[lon lat]=meshgrid(x,y);
vec(:,:)=sqrt(data_u1.^2+data_v1.^2);
for ii=5:111-4
    for jj=5:116-4
        vec(ii,jj,:)=nanmean(nanmean(vec(ii-4:ii+4,jj-4:jj+4,:),1),2);
    end
end
for ii=2:111-1
    for jj=2:116-1
        vec(ii,jj,:)=nanmean(nanmean(vec(ii-1:ii+1,jj-1:jj+1,:),1),2);
    end
end
vec(100:105,1:27)=NaN;
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
m_contourf(lon,lat,vec,50,'k','edgecolor','none');
hold on
clear lon lat x y
x=117:0.4:128.5;
y=30:0.5:41.0;
[lon lat]=meshgrid(x,y);
m_proj('miller','lon',[117 128.5],'lat',[30. 41.0]);
hold on
data_u(21:23,1:8)=NaN;
data_v(21:23,1:8)=NaN;
data_u(21,3)=10;
data_v(21,3)=0;
%m_vec(.05,lon,lat,data_u,data_v,'headangle',55,'headlength',4.,'shaftwidth',0.8)
m_quiver(lon,lat,data_u,data_v,1.5,'color',[0 0 0],'LineWidth',1.2)
hold on
m_coast('color',[0 0 0]','linewidth',2.)
hold on
m_grid('linestyle','none','tickdir','out','linewidth',1.2,'fontsize',16);
m_text(117.5,40.3,'10m/s','fontsize',14)
colorbar
caxis([0 12])
h=colorbar;
set(h,'fontsize',15,'YTick',[0:2:12])
set(get(h,'Title'),'string','m/s ','fontsize',15);
title('10m Wind of guess at 2010-05-29-21','fontsize',18,'color','k')
print('-dpdf','C:\Users\Administrator\Documents\Visual Studio 2008\Projects\successive correction\figure_ud_res')