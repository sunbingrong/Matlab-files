subplot(2,1,2)
m_proj('Miller Cylindrical','lon',[120,240],'lat',[-1,60]);
m_grid('box','off')
% hold on
% m_quiver(x,y,usmean',vsmean',2,'color',[0 0 0],'LineWidth',1.3)

m_vec(0.7,x,y,usmean',vsmean','headangle',30,'headwidth',NaN,'headlength',10 ,'shaftwidth',1)
m_coast('patch',[0 0 0]);
title('Velocity, extended summer')
subplot(2,1,1)
% subplot(2,1,1,'position',[.2 .58  0.5  .35])
m_proj('Miller Cylindrical','lon',[120,240],'lat',[-1,60]);
m_grid('box','off')
% hold on
m_vec(0.8,x,y,uwmean',vwmean','headangle',30,'headwidth',NaN,'headlength',5 ,'shaftwidth',1)
% m_quiver(x,y,uwmean',vwmean',2,'color',[0 0 0],'LineWidth',1.3)
m_coast('patch',[0 0 0]);
title('Velocity, extended winter')