%% rain_interpolation.
clear
load successive_ua.txt
load successive_va.txt
successive_ua(successive_ua==-999)=0;
successive_ua(successive_ua==-999)=0;
[lon,lat]=meshgrid([117:0.1:128.5],[30:0.1:41]);
m_proj('miller','long',[110 140],'lat',[25 45]);
m_coast('patch',[.9 .9 .9],'edgecolor','none');
m_grid('tickdir','out','yaxislocation','left',...
       'xaxislocation','bottom','ticklen',.02);
hold on
m_quiver(lon,lat,successive_ua,successive_ua);
colorbar
%% temp_interpolation.
clear
load sstemp.mat
sstemp(sstemp==-999)=0;
[lon,lat]=meshgrid([114:0.5:125.5],[34:0.5:41.5]);
m_proj('miller','long',[110 140],'lat',[30 45]);
m_coast('patch',[.9 .9 .9],'edgecolor','none');
m_grid('tickdir','out','yaxislocation','left',...
       'xaxislocation','bottom','ticklen',.02);
hold on
m_contourf(lon,lat,sstemp,'linestyle','none');
my_handle=colorbar;
set(get(my_handle,'title'),'string','°„C');