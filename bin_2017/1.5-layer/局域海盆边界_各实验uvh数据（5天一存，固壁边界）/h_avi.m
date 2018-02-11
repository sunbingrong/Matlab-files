clear;
clc
%load ('../Input/map3.mat');
load('basic_uvh.mat');
writerObj = VideoWriter('basic_h.avi');
writerObj.FrameRate = 1;
writerObj.Quality   = 100;
open(writerObj);
fig=figure;
%cMax=max(max(max(H_NP)));
%cMin=min(min(min(H_NP)));
for k = 1:360
   lon = 100:1/4:290;
   lat = -20:1/4:35;
   %a = axes;
   %m_proj('miller','lon',[100 EB],'lat',[10 20]);
   contourf(lon,lat,h(:,:,k)');
   %[c,h]=contourf(lon,lat,H_NP(:,:,k)');
   %m_grid('linestyle','none');
   %m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]);
   %set(a, 'CLim', [cMin cMax]);
   colorbar;
   %set(h,'ShowText','on')
   %colormap(map3)
   frame(k) = getframe(fig);
   writeVideo(writerObj,frame(k));
end
close(writerObj);