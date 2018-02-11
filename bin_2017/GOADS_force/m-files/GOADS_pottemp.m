% 1980.01 ---- 2017.04
clear;clc;
GOADS_URL = 'http://apdrc.soest.hawaii.edu:80/dods/public_data/Reanalysis_Data/GODAS/monthly/';
GOADS_lat     = ncread([GOADS_URL,'potmp'],'lat');
GOADS_lon     = ncread([GOADS_URL,'potmp'],'lon');
GOADS_lev     = ncread([GOADS_URL,'potmp'],'lev');
GOADS_time    = ncread([GOADS_URL,'potmp'],'time');
GOADS_pottemp = zeros(length(GOADS_lon),length(GOADS_lat),12,length(GOADS_lev));
% read temperature data
a=find(GOADS_lon>=100 & GOADS_lon<=290);
b=find(GOADS_lat>=-20 & GOADS_lat<=35);    % a b the domain of need_data
lon_num=length(a);
lat_num=length(b);
% data time begin 1-1-1 00:00:0.0
year_month_day_0 = [1 01 01];
date_num_0 = datenum(year_month_day_0);
daynum = GOADS_time + date_num_0;
GOADS_year_month_day = datestr(daynum,'yyyymmdd');
for k = 241:length(GOADS_time)
%for k = 241
    pottemp = ncread([GOADS_URL,'potmp'],'potdsl',[a(1) b(1) 1 k],[lon_num lat_num inf 1]);
    save(['../Output/GOADS_pottemp/GOADS_pottemp_',GOADS_year_month_day(k,1:6),'.mat'],'pottemp');
    k
end
%save('../Output/GOAD_lon.mat','GOADS_lon');save('../Output/GOADS_lat.mat','GOADS_lat');save('../Output/GOADS_depth.mat','GOADS_lev');
%% rename pottemp data
fileFolder=fullfile('D:\Applications\Matlab2015b\bin\bin文件\bin（2015）\GOADS_force\Output');
files = dir([fileFolder,'\*.mat']);
len=length(files);
for i=1:len
    oldname=files(i).name;
    newname = [oldname(1:14),num2str(str2num(oldname(15:18))-20),oldname(19:end)];
    %newname=strcat('RH_', oldname);
    command = ['rename' 32 oldname 32 newname];
    status = dos(command);
    if status == 0
        disp([oldname, ' 已被重命名为 ', newname])
    else
        disp([oldname, ' 重命名失败!'])
    end
end