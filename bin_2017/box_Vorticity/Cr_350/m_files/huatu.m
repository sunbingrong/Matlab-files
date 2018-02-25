clear;
clc
load('../Output/H_290E.mat')
max_H = max(max(max(H_NP)));
min_H = min(min(min(H_NP)));
nx  = 761;
ny  = 101;
t   = 432;

 for i=1:12
     sum = 0;
     for n = 1:36
         sum   = sum + H_NP(:,:,12*(n-1)+i);
     end
     a(:,:,i) = sum/36;
 end
 for i = 1:12
     b(:,i) = a(40,:,i);
 end
 figure
 [c,h] = contour(a(:,:,12)');
 set(h,'ShowText','on','labelspacing',1000)
 %set(h,'ShowText','on','TextList',0)
 %%
 load H_NP
cMax=max(max(max(H_NP)));
cMin=min(min(min(H_NP)));
for i=1:12
     sum = 0;
     for n = 1:36
         sum   = sum + H_NP(:,:,12*(n-1)+i);
     end
     H_a(:,:,i) = sum;
end
for k = 1:12
     figure
     lon = 120:1/4:135;
     lat = 10:1/4:20;
     a = axes;
     m_proj('miller','lon',[120 135],'lat',[10 20]);    
     [c,h]=m_contour(lon,lat,H_a(:,:,k)'); 
     m_grid('linestyle','none');    
     m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]);
     set(a, 'CLim', [cMin cMax]);
     colorbar;
     set(h,'ShowText','on','TextList',0)
end
%%
 load H_NP.mat
cMax=max(max(max(H_NP)));
cMin=min(min(min(H_NP)));
for i=1:12
     sum = 0;
     for n = 1:36
         sum   = sum + H_NP(:,:,12*(n-1)+i);
     end
     H_a(:,:,i) = sum;
end
writerObj = VideoWriter('H_NP.avi');
writerObj.FrameRate = 0.5;
writerObj.Quality   = 100;
open(writerObj);
fig=figure;
 for k = 1:12
     lon = 120:1/4:135;
     lat = 10:1/4:20;
     a = axes;
     m_proj('miller','lon',[120 135],'lat',[10 20]);    
     [c,h]=m_contour(lon,lat,H_a(:,:,k)'); 
     m_grid('linestyle','none');    
     m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]);
     set(a, 'CLim', [cMin cMax]);
     colorbar;
     %set(h,'ShowText','on')
     set(h,'ShowText','on','TextList',0)
     frame(k) = getframe(fig);
     writeVideo(writerObj,frame(k));
 end
close(writerObj);
