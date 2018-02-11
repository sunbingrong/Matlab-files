% 1980.01 ---- 2017.04
clear;clc;
GOADS_URL = 'http://apdrc.soest.hawaii.edu:80/dods/public_data/Reanalysis_Data/GODAS/monthly/';
GOADS_lat     = ncread([GOADS_URL,'salt'],'lat');
GOADS_lon     = ncread([GOADS_URL,'salt'],'lon');
GOADS_lev     = ncread([GOADS_URL,'salt'],'lev');
GOADS_time    = ncread([GOADS_URL,'salt'],'time');
% read uv & salinity data
a=find(GOADS_lon>=100 & GOADS_lon<=290);
b=find(GOADS_lat>=-20 & GOADS_lat<=35);    % a b the domain of need_data
lon_num=length(a);
lat_num=length(b);
% datenum time begin 0-0-0 00:00:0.0 
% GOADS data time begin 1-1-1 00:00:0.0
year_month_day_0 = [1 01 01];
date_num_0 = datenum(year_month_day_0);
daynum = GOADS_time + date_num_0;
GOADS_year_month_day = datestr(daynum,'yyyymmdd');
for k = 1:length(GOADS_time)
    %for i = 1
    salt = ncread([GOADS_URL,'salt'],'saltydsl',[a(1) b(1) 1 k],[lon_num lat_num inf 1]);
    save(['../Output/GOADS_salt/GOADS_salt_',GOADS_year_month_day(k,1:6),'.mat'],'salt');
    %u = ncread([GOADS_URL,'ucur'],'uogrddsl',[a(1) b(1) 1 k],[lon_num lat_num inf 1]);
    %save(['../Output/GOADS_u/GOADS_u_',GOADS_year_month_day(k,1:6),'.mat'],'u');
    %v = ncread([GOADS_URL,'vcur'],'vogrddsl',[a(1) b(1) 1 k],[lon_num lat_num inf 1]);
    %save(['../Output/GOADS_v/GOADS_v_',GOADS_year_month_day(k,1:6),'.mat'],'v');
    k
end