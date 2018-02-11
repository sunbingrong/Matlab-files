clear;clc
% u & v :lon*lat*depth*time
GOADS_URL = 'http://apdrc.soest.hawaii.edu:80/dods/public_data/Reanalysis_Data/GODAS/monthly/';
GOADS_u_lon = ncread([GOADS_URL,'ucur'],'lon');
GOADS_u_lat = ncread([GOADS_URL,'ucur'],'lat');
GOADS_salt_lon = importdata('../Output/GOADS_salt_lon.mat'); 
GOADS_salt_lat = importdata('../Output/GOADS_salt_lat.mat'); 
u_lon = GOADS_u_lon(GOADS_u_lon>=100 & GOADS_u_lon<=290);
u_lat = GOADS_u_lat(GOADS_u_lat>=-20 & GOADS_u_lat<=35);
h_lon = GOADS_salt_lon(GOADS_salt_lon>=100 & GOADS_salt_lon<=290);
h_lat = GOADS_salt_lat(GOADS_salt_lat>=-20 & GOADS_salt_lat<=35);
load('../Output/GOADS_upper_u.mat'); load('../Output/GOADS_upper_v.mat');
load('../Output/therm_depth.mat');

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
    
    temp = GOADS_upper_u(:,:,month);
    temp = interp2(u_lat,u_lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    temp(isnan(topo))=nan;
    GOADS_uub(:,:,month) = temp; % lon*lat
    
    temp = GOADS_upper_v(:,:,month);
    temp = interp2(u_lat,u_lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    temp(isnan(topo))=nan;
    GOADS_vvb(:,:,month) = temp; % lon*lat
    
    temp = thermal_depth(:,:,month);
    temp = interp2(h_lat,h_lon,temp,xq,yq,'linear');
    temp = temp(xloc,yloc);
    temp(isnan(topo))=nan;
    GOADS_hhb(:,:,month) = temp; % lon*lat
    
end
% Input boundary data into Input folder 
clear month;
GOADS_uub(isnan(GOADS_uub))=0;
GOADS_vvb(isnan(GOADS_vvb))=0;
GOADS_hhb(isnan(GOADS_hhb))=0;

[im,jm,tm] = size(GOADS_uub);
fid_aa = fopen('../Input/GOADS_uub.dat','wb');
fid_bb = fopen('../Input/GOADS_vvb.dat','wb');
fid_cc = fopen('../Input/GOADS_hhb.dat','wb');
for i=1:tm
    aa = reshape(GOADS_uub(:,:,i),[1 im*jm]);
    fwrite(fid_aa,aa,'real*4');
    bb = reshape(GOADS_vvb(:,:,i),[1 im*jm]);
    fwrite(fid_bb,bb,'real*4');
    cc = reshape(GOADS_hhb(:,:,i),[1 im*jm]);
    fwrite(fid_cc,cc,'real*4');
end
% fclose(fid_aa);fclose(fid_bb);fclose(fid_cc);
% save('../Input/GOADS_uub.mat','GOADS_uub');
% save('../Input/GOADS_vvb.mat','GOADS_vvb');
% save('../Input/GOADS_hhb.mat','GOADS_hhb');