clear;close all
% load u.dat
% load v.dat
load uv_zeta_da.mat
load zhandian.dat
lon=zhandian(:,1);
lat=zhandian(:,2);
m_proj('miller','lon',[121.1 121+26/60],'lat',[37.5 37+45/60]);
m_gshhs_h('patch','y')
hold on
% for i=1:25
% m_quiver(lon,lat,squeeze(u2(i,10,:))/10,squeeze(v2(i,10,:))/10,0,'b');
% end
m_quiver(121+10/60,37+32/60,0.3/10,0,0,'b')
m_text(121+10/60,37+32/60,'0.3m/s','verticalalignment','top','fontsize',16)
m_grid('box','fancy','tickdir','out','linestyle','none','fontsize',16);
