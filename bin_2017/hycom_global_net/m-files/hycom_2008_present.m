% read the network HYCOM
clear;clc
HYCOM_global_url = 'http://apdrc.soest.hawaii.edu:80/dods/public_data/Model_output/HYCOM/global/hycomV';
depth = ncread(HYCOM_global_url,'lev');
lat = ncread(HYCOM_global_url,'lat'); lon = ncread(HYCOM_global_url,'lon');
time = ncread(HYCOM_global_url,'time');
a=find(lon>=100 & lon<=210);
b=find(lat>=-20 & lat<=35);    % a b the domain of need_data
lon_num=length(a);
lat_num=length(b);
%---------------------------------date num-------------------------------%%
cha_day = time;
year_month_day_0 = [1 1 1];
date_num_0 = datenum(year_month_day_0);
Hycom_daynum = cha_day + date_num_0;
Hycom_year_month_day = datestr(Hycom_daynum-2,'yyyymmdd');
k = 0;
for i = 1:3525    %start from 1997.01.01 - 2012.12.31%
    day_name = str2double(Hycom_year_month_day(i,end-1:end));
    if (day_name == 15)
        tic;
%         temp_datenum = datenum(Hycom_year_month_day(i,:),'yyyymmdd');
%         temp_chanum = 24*(temp_datenum - date_num_0);
%         subscript_date = find(time==temp_chanum);
        k = k + 1;
        V = ncread(HYCOM_global_url,'water_v',[a(1) b(1) 1 i],[lon_num lat_num 33 1]);
        V_temp = reshape(mean(V,3),[lon_num lat_num]); 
        save(['../Output/Up600/HYCOM_V_',num2str(k,'%03d'),'.mat'],'V_temp');
        k
        toc
    end
end
save('../Output/lon.mat','lon');save('../Output/lat.mat','lat');save('../Output/depth.mat','depth');