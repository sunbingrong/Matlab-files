clear;
clc
load ('../Input/map3.mat');
load('../Output/Rossby.mat');
writerObj = VideoWriter('../Output/Rossby.avi');
writerObj.FrameRate = 1;
writerObj.Quality   = 100;
open(writerObj);
fig=figure;
%cMax=max(max(max(H_NP)));
%cMin=min(min(min(H_NP)));
for k = 1:360
   lon = 1:480;
   lat = 1:240;
   %a = axes;
   %m_proj('miller','lon',[100 EB],'lat',[10 20]);
   contourf(lon,lat,H_NP(:,:,k)');
   %[c,h]=contourf(lon,lat,H_NP(:,:,k)');
   %m_grid('linestyle','none');
   %m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]);
   %set(a, 'CLim', [cMin cMax]);
   colorbar;
   %set(h,'ShowText','on')
   colormap(map3)
   frame(k) = getframe(fig);
   writeVideo(writerObj,frame(k));
end
close(writerObj);