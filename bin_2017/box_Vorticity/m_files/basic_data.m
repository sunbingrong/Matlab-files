clc; clear; close all

 nx = 761;
 ny = 101;
 t  = 432;
 fid = fopen('/home/user/sbr/sbr/box_Vorticity/Output/H_290E.dat','rb');
 data=fread(fid,inf,'real*4');
 fclose(fid);
 h = reshape(data,nx,ny,t);
 h(h==-9999) = NaN;

 lon_area=[100 290]; lat_area=[10 35]; resolution = 0.25; % lon*lat 361*121

 h_NBL = -h(81:nx,1:41,:);           % 120E-EB  10N-20N
 h_mean = nanmean(h_NBL,3);
 %for i = 1:t
 %   aa(:,:,i) = h_NBL(:,:,i)-h_mean;  % 120E-EB  10-20N
    %KEI(i) = nanmean(nanmean(aa));
 %end
 H_NP = h_NBL;
 
 temp = zeros(41,12);

save('/home/user/sbr/sbr/Vorticity/Output/H_290E.mat','H_NP');


 max_H = max(max(max(H_NP)));
 min_H = min(min(min(H_NP)));


 for i = 1:12
     sum = 0;
     for year = 36
         sum = sum + H_NP(40,:,12*(year-1)+i);   %130E boundary
     end
     temp(:,i) = sum;
 end
    
    b = temp./1;

 NBL = b;
 save('/home/user/sbr/sbr/Vorticity/Output/NBL_290E.mat','NBL')

% t = 1993+1/12:1/12:2015;
% load('D:\MIROC4h\AVISO\KEI_AVISO_monthly.mat');
% plotyy(t,KEI_AVISO_monthly,t,KEI(169:end))
% corr2(KEI_AVISO_monthly,KEI(169:end))

% pcolor(h(:,:,150)'); shading interp;
% colorbar;

% fid = fopen('model_cr.dat','rb');
% data=fread(fid,inf,'real*4');
% fclose(fid);
% cr = reshape(data,nx,ny);
% 
% fid = fopen('model_wind_ECMWF.dat','rb');
% data=fread(fid,inf,'real*4');
% fclose(fid);
% curl = reshape(data,nx,ny,t);
