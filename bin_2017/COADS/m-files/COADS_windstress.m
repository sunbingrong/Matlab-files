% COADS wind stress
clear;clc
% sigma :lon*lat*time*depth
% u & v :lon*lat*time*depth
% lon : 0.25E-359.75E lat : -75.25S-89.25N resolution : 0.5
lon = ncread('../Input/taux.nc','X'); lat = ncread('../Input/taux.nc','Y');
taux_COADS = ncread('../Input/taux.nc','taux');
tauy_COADS = ncread('../Input/tauy.nc','tauy');
load('../Input/case290E_topo.dat');
topo = reshape(case290E_topo,[761 221]);
topo(topo==0)=nan;

% define region and resolution
lon_area=[100 290]; lat_area=[-20 35]; resolution = 0.25;

lon_M = 0:resolution:360; lat_M = -90:resolution:90;
xloc=find(lon_M>=lon_area(1) & lon_M<=lon_area(2));
yloc=find(lat_M>=lat_area(1) & lat_M<=lat_area(2));
[xq yq] = meshgrid(lat_M,lon_M);
[X1,Y1]=meshgrid(lon_M(xloc),lat_M(yloc));
for month = 1:12
    
    temp = taux_COADS(:,:,month);
    temp = interp2(lat,lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    temp(isnan(topo))=-9.9;
    taux(:,:,month) = temp; % lon*lat
    
    temp = tauy_COADS(:,:,month);
    temp = interp2(lat,lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    temp(isnan(topo))=-9.9;
    tauy(:,:,month) = temp; % lon*lat
     
end

 taux(taux<=-5)=nan;tauy(tauy<=-5)=nan;

% [im,jm,tm] = size(taux);
% fid_aa = fopen('../Input/taux_COADS.dat','wb');
% fid_bb = fopen('../Input/tauy_COADS.dat','wb');
% for i=1:tm
%     aa = reshape(taux(:,:,i),[1 im*jm]);
%     fwrite(fid_aa,aa,'real*4');
%     bb = reshape(tauy(:,:,i),[1 im*jm]);
%     fwrite(fid_bb,bb,'real*4');
% end
% fclose(fid_aa);fclose(fid_bb);
% save('../Input/taux_COADS.mat','taux');save('../Input/tauy_COADS.mat','tauy');