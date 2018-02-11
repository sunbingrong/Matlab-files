clear;clc
% sigma :lon*lat*time*depth
% u & v :lon*lat*time*depth
% lon : 0.25E-359.75E lat : -75.25S-89.25N resolution : 0.5
load('../Output/longitude.mat'); load('../Output/latitude.mat');
load('../Output/u_mean.mat'); load('../Output/v_mean.mat');
load('../Output/upper_H.mat');

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
    
    temp = u_mean(:,:,month);
    temp = interp2(lat,lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    temp(isnan(topo))=nan;
    uub(:,:,month) = temp; % lon*lat
    
    temp = v_mean(:,:,month);
    temp = interp2(lat,lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    temp(isnan(topo))=nan;
    vvb(:,:,month) = temp; % lon*lat
    
    temp = h(:,:,month);
    temp = interp2(lat,lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    temp(isnan(topo))=nan;
    hhb(:,:,month) = temp; % lon*lat
    
end
clear month;
uub(isnan(uub))=0;vvb(isnan(vvb))=0;hhb(isnan(hhb))=0;

[im,jm,tm] = size(uub);
fid_aa = fopen('../Input/uub.dat','wb');
fid_bb = fopen('../Input/vvb.dat','wb');
fid_cc = fopen('../Input/hhb.dat','wb');
for i=1:tm
    aa = reshape(uub(:,:,i),[1 im*jm]);
    fwrite(fid_aa,aa,'real*4');
    bb = reshape(vvb(:,:,i),[1 im*jm]);
    fwrite(fid_bb,bb,'real*4');
    cc = reshape(hhb(:,:,i),[1 im*jm]);
    fwrite(fid_cc,cc,'real*4');
end
fclose(fid_aa);fclose(fid_bb);fclose(fid_cc);
save('../Output/uub.mat','uub');save('../Output/vvb.mat','vvb');save('../Output/hhb.mat','hhb');
%% soda wind stress
clear;clc
% sigma :lon*lat*time*depth
% u & v :lon*lat*time*depth
% lon : 0.25E-359.75E lat : -75.25S-89.25N resolution : 0.5
load('../Output/longitude.mat'); load('../Output/latitude.mat');
load('../Input/taux_soda.mat'); load('../Input/tauy_soda.mat');

% define region and resolution
lon_area=[100 290]; lat_area=[-20 35]; resolution = 0.25;

lon_M = 0:resolution:360; lat_M = -90:resolution:90;
xloc=find(lon_M>=lon_area(1) & lon_M<=lon_area(2));
yloc=find(lat_M>=lat_area(1) & lat_M<=lat_area(2));
[xq yq] = meshgrid(lat_M,lon_M);
[X1,Y1]=meshgrid(lon_M(xloc),lat_M(yloc));
for month = 1:12
    
    temp = taux_soda(:,:,month);
    temp = interp2(lat,lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    taux(:,:,month) = temp; % lon*lat
    
    temp = tauy_soda(:,:,month);
    temp = interp2(lat,lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    tauy(:,:,month) = temp; % lon*lat
     
end

taux(isnan(taux))=0;tauy(isnan(tauy))=0;

[im,jm,tm] = size(taux);
fid_aa = fopen('../Input/taux.dat','wb');
fid_bb = fopen('../Input/tauy.dat','wb');
for i=1:tm
    aa = reshape(taux(:,:,i),[1 im*jm]);
    fwrite(fid_aa,aa,'real*4');
    bb = reshape(tauy(:,:,i),[1 im*jm]);
    fwrite(fid_bb,bb,'real*4');
end
fclose(fid_aa);fclose(fid_bb);
save('../Output/taux.mat','taux');save('../Output/tauy.mat','tauy');