%% Indian_Pacific
%m_proj('lambert','long',[30 290],'lat',[-45 30]);
m_proj('miller','long',[30 290],'lat',[-45 45]);
m_coast('patch',[1 .85 .7]);
%m_elev('contourf',[500:500:6000]);
m_grid('box','fancy','tickdir','in');
%colormap(flipud(copper));
%% 带流场的地形图Indian_Pacific
%m_proj('lambert','long',[30 290],'lat',[-45 30]);
[lon,lat]=meshgrid([30:0.5:290],[-45:0.5:30]);
m_quiver(lon',lat',u(:,:,360),v(:,:,360));
hold on
m_proj('miller','long',[30 290],'lat',[-45 30]);
m_coast('patch',[1 .85 .7],'edgecolor','none');
m_grid('tickdir','out','yaxislocation','right',...
       'xaxislocation','bottom','xlabeldir','end','ticklen',.02);
%% Nice looking data
clear
[lon,lat]=meshgrid([-136:2:-114],[36:2:54]);
u=sin(lat/6);
v=sin(lon/6);
m_proj('oblique','lat',[56 30],'lon',[-132 -120],'aspect',.8);
m_coast('patch',[.9 .9 .9],'edgecolor','none');
m_grid('tickdir','out','yaxislocation','right',...
       'xaxislocation','top','xlabeldir','end','ticklen',.02);
hold on;
m_quiver(lon,lat,u,v);
xlabel('Simulated surface winds');
%%
load U.mat
load V.mat
m=3;
u1=zeros(73,144);v1=zeros(73,144);
for i=1:12:816
    u1=U(:,:,i)'+u1;
    v1=V(:,:,i)'+v1;
end
u1=u1./68;v1=v1./68;
[lon,lat]=meshgrid([0:2.5:357.5],[-90:2.5:90]);
m_proj('Miller Cylindrical','lat',[-90 90],'lon',[0 357.5]);
[hp,ht]=m_vec(10,lon(1:m:end,1:m:end),lat(1:m:end,1:m:end),u1(1:m:end,1:m:end),v1(1:m:end,1:m:end));
set(hp,'linewidth',[1.2])
m_coast('patch',[1 1 1],'linewidth',[2]);
m_grid('linestyle','none','box','on','fontsize',[10],'linewidth',[2])
%% 易李老师
[lon,lat]=meshgrid([0:2.5:357.5],[-90:2.5:90]);
m_proj('Miller Cylindrical','lat',[-90 90],'lon',[0 357.5]);
[hp]=m_quiver(lon,lat,u1,v1,'linewidth',[1.2],'color',[0 0 0]);
m_coast('line','color',[0 0 0],'linewidth',[2]);
m_grid('linestyle','none','box','on','fontsize',[12],'linewidth',[2],...
    'ytick',[-20 0 20 40 60],'xtick',[ 120 150 180 210 240 ]);
%% 画热量收支
load thflx.mat
thflx1=zeros(360,418);
for i=1:12
    thflx1=thflx1+thflx(:,:,i);
end
thflx1=thflx./12;
[lon,lat]=meshgrid([0.5:1:359.5],[-74.5:1/3:64.499]);
m_proj('miller','lat',[-74.5 64.499],'lon',[0.5 359.5]);
m_coast('patch',[1 .85 .7]);
m_contourf(lon,lat,thflx1(:,1:417)');
m_grid('box','fancy','tickdir','in');