clc; clear; close all

 
 nx = 200;
 ny = 51;
 t  = 240;
 fid = fopen('/home/user/sbr/sbr/Yang_barotropic/Output/H.dat','rb');
 data=fread(fid,inf,'real*4');
 fclose(fid);
 h = reshape(data,nx,ny,t);
 h(h==-9999) = NaN;
 
 %cMax=max(max(max(h)));
 %cMin=min(min(min(h)));

 lon_area=[100 290]; lat_area=[10 35]; resolution = 0.25; % lon*lat 761*101

 h_NBL = -h;           % 120E-EB  10N-20N
 h_mean = mean(h_NBL,3);
 aa = zeros(nx,ny,t);
 for i = 1:t
    aa(:,:,i) = h_NBL(:,:,i)-h_mean;  % 120E-EB  10-20N
 end
 H_NP = h_NBL;
 H_a  = aa;
 
  
 save('/home/user/sbr/sbr/Yang_barotropic/Output/H.mat','H_NP');
 save('/home/user/sbr/sbr/Yang_barotropic/Output/H_a.mat','H_a');


 max_H = max(max(max(H_NP)));
 min_H = min(min(min(H_NP)));

 
