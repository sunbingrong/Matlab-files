%%
     SSH_GoDAS = ncread('SSH_GoDAS.nc','sshg');
     a = SSH_GoDAS(:,:,1);
     lon = 130:169;
     lat = 20:1/3:(45-1/3);
     m_contourf(lon,lat,a','linestyle','none');
     m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]);
     m_proj('miller','lon',[130 169],'lat',[20 45]);
     m_grid('linestyle','none');
     colorbar;
%%  µÿÕº–≈œ¢
     m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]);
     m_proj('miller','lon',[100 270],'lat',[-12 45]);
     m_grid('linestyle','none');
   