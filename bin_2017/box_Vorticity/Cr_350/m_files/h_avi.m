%%
clear;
clc
for EB = 280
load(['../Output/H_',num2str(EB),'E.mat'])
writerObj = VideoWriter(['../Output/',num2str(EB),'E_h.avi']);
writerObj.FrameRate = 1;
writerObj.Quality   = 100;
open(writerObj);
fig=figure;
cMax=max(max(max(H_NP)));
cMin=min(min(min(H_NP)));
% for mon = 1:432
%     for  i = 1:(EB-120)*4+1
%         H_NP(i,:,mon) = 600/(cMax-cMin).*H_NP(i,:,mon)+300-600/(cMax-cMin)*cMax;
%     end
% end   

for k = 1:432
   lon = 120:1/4:EB;
   lat = 10:1/4:20;
   a = axes;
   %m_proj('miller','lon',[120 EB],'lat',[10 20]);
   contourf(lon,lat,H_NP(:,:,k)');
   %[c,h]=m_contourf(lon,lat,H_a(:,:,k)');
   %m_grid('linestyle','none');
   %m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]);
   set(a, 'CLim', [cMin cMax]);
   n = mod(k,12);
   if(n==0) n =12; end
   title(['month = ',num2str(n)])
   colorbar;
   %set(h,'ShowText','on')
   frame(k) = getframe(fig);  
   writeVideo(writerObj,frame(k));
   clf;
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
     m_contourf(lon,lat,h(:,:,360)','linestyle','none');
     m_grid('linestyle','none');
     m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[1]); 
     caxis([0,1]);
     colorbar;
     frame(k) = getframe(fig);
     writeVideo(writerObj,frame(k));
    
 end
close(writerObj);