%%
%load('basic_uvh.mat')
for i = 140:10:150
     str1=num2str(i);
     str2='E_uvh.mat';
     str3=[str1,str2];
     load(str3)
writerObj = VideoWriter([str1,'E_h.avi']);
writerObj.FrameRate = 5;
writerObj.Quality   = 100;
open(writerObj);
fig=figure;
cMax=max(max(max(h)));
cMin=min(min(min(h)));
 for k = 1:60:720
     lon = 100:1/4:i;
     lat = -20:1/4:35;
     a = axes;
     m_proj('miller','lon',[100 i],'lat',[-20 35]);
     m_grid('linestyle','none');
     m_contourf(lon,lat,h(:,:,k)','linestyle','none');
     m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]);
     set(a, 'CLim', [cMin cMax]);
     colorbar;
     frame(k) = getframe(fig);
     writeVideo(writerObj,frame(k));
 end
end
close(writerObj);
%%
load('basic_uvh.mat')
load('modeltopo_quar_NP_200m_isobath.dat')
size(h)

writerObj = VideoWriter('basic_h.avi');
writerObj.FrameRate = 5;
writerObj.Quality   = 100;
open(writerObj);
fig=figure;
 for k = 1:15:360
     lon = 100:1/4:290;
     lat = -20:1/4:35;
     m_proj('miller','lon',[100 290],'lat',[-20 35]);
     m_grid('linestyle','none');
     m_contourf(lon,lat,h(:,:,360)','linestyle','none');
     m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]); 
     caxis([0,1]);
     colorbar;
     frame(k) = getframe(fig);
     writeVideo(writerObj,frame(k));
    
 end
close(writerObj);
