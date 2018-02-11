% ECMWF wind stress into 1.5-layer model input data
clear;clc
% taux & tauy :lon*lat*time
lon = ncread('../Input/taux.nc','longitude'); lat = ncread('../Input/taux.nc','latitude');
taux_ECMWF = importdata('../Input/taux_ECMWF.mat');
tauy_ECMWF = importdata('../Input/tauy_ECMWF.mat');

taux_ECMWF(isnan(taux_ECMWF))=-9.9;
tauy_ECMWF(isnan(taux_ECMWF))=-9.9;

% taux(taux<=-5)=nan;tauy(tauy<=-5)=nan;

[im,jm,tm] = size(taux_ECMWF);
fid_aa = fopen('../Input/taux_ECMWF.dat','wb');
fid_bb = fopen('../Input/tauy_ECMWF.dat','wb');
for i=1:tm
    aa = reshape(taux_ECMWF(:,:,i),[1 im*jm]);
    fwrite(fid_aa,aa,'real*4');
    bb = reshape(tauy_ECMWF(:,:,i),[1 im*jm]);
    fwrite(fid_bb,bb,'real*4');
end
fclose(fid_aa);fclose(fid_bb);