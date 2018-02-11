% Turn into ECMWF monthly wind stress
clear;clc
% taux & tauy :lon*lat*time
% lon : 0.25E-359.75E lat : 90S-90N resolution : 0.25
lon  = ncread('../Input/taux.nc','longitude');
lat  = ncread('../Input/taux.nc','latitude');
time = ncread('../Input/taux.nc','time');
taux_temp = ncread('../Input/taux.nc','iews');
tauy_ECMWF = ncread('../Input/tauy.nc','inss');
taux_ECMWF = zeros(length(lon),length(lat),15*12);
taux_ECMWF(:,:,1:11) = taux_temp(:,:,1:11);
taux_ECMWF(:,:,13:end) = taux_temp(:,:,12:end);

load('../Input/case290E_topo.dat');
topo = reshape(case290E_topo,[761 221]);
topo(topo==0)=nan;

% calculate time
year_month_day_0 = [1900 01 01];
date_num_0 = datenum(year_month_day_0);
daynum = time/24 + date_num_0;
ECMWF_year_month_day = datestr(double(daynum),'yyyymmdd');

% define region and resolution
lon_area=[100 290]; lat_area=[-20 35]; resolution = 0.25;

lon_M = 0:resolution:360; lat_M = -90:resolution:90;
xloc=find(lon_M>=lon_area(1) & lon_M<=lon_area(2));
yloc=find(lat_M>=lat_area(1) & lat_M<=lat_area(2));
[xq yq] = meshgrid(lat_M,lon_M);
[X1,Y1]=meshgrid(lon_M(xloc),lat_M(yloc));
for month = 1:12
    temp_x = zeros(length(lon),length(lat));
    temp_y = zeros(length(lon),length(lat));
    for year = 1:15
        
        temp_x = temp_x + taux_ECMWF(:,:,12*(year-1)+month);
        temp_y = temp_y + tauy_ECMWF(:,:,12*(year-1)+month);
        
    end
    temp_x = fliplr(temp_x);    temp_y = fliplr(temp_y);
    temp_x = temp_x(xloc,yloc); temp_y = temp_y(xloc,yloc);
    temp_x(isnan(topo))=nan;    temp_y(isnan(topo))=nan;
    if month ==12
        taux(:,:,month) = temp_x/11; % lon*lat
    else
        taux(:,:,month) = temp_x/12; % lon*lat
    end
        tauy(:,:,month) = temp_y/12; % lon*lat
end
save('../Input/taux_ECMWF.mat','taux');save('../Input/tauy_ECMWF.mat','tauy');