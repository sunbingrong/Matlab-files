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
%% 易李老师
[lon,lat]=meshgrid([0:2.5:357.5],[-90:2.5:90]);
m_proj('Miller Cylindrical','lat',[-90 90],'lon',[0 357.5]);
[hp]=m_quiver(lon,lat,u1,v1,'linewidth',[1.2],'color',[0 0 0]);
m_coast('line','color',[0 0 0],'linewidth',[2]);
m_grid('linestyle','none','box','on','fontsize',[12],'linewidth',[2],...
    'ytick',[-20 0 20 40 60],'xtick',[ 120 150 180 210 240 ]);




