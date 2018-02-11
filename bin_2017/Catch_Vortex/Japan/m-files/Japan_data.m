clear;clc
lat  = ncread('http://apdrc.soest.hawaii.edu:80/dods/public_data/FRA-JCOPE2/el','lat');
lon  = ncread('http://apdrc.soest.hawaii.edu:80/dods/public_data/FRA-JCOPE2/el','lon');
time = ncread('http://apdrc.soest.hawaii.edu:80/dods/public_data/FRA-JCOPE2/el','time');
% 1993-01-01 to 2009-12-31
year_month_day_0 = [1993 01 01]; year_month_day_1 = [2009 12 31];
date_num_0 = datenum(year_month_day_0); 
date_num_1 = datenum(year_month_day_1);
%ssh = zeros(length(lon),length(lat),12);
%parpool local
tic
for year = 1993:1996
    date_first = [year 01 01]; date_num_first = datenum(date_first);
    date_end   = [year 12 31]; date_num_end   = datenum(date_end);
    first_num  = date_num_first - date_num_0 + 1;
    day = date_num_end - date_num_first + 1;
    ssh = ncread('http://apdrc.soest.hawaii.edu:80/dods/public_data/FRA-JCOPE2/el','el',[1 1 1 first_num],[inf inf inf day]);
    u   = ncread('http://apdrc.soest.hawaii.edu:80/dods/public_data/FRA-JCOPE2/u','u',[1 1 1 first_num],[inf inf 1 day]); % surface
    v   = ncread('http://apdrc.soest.hawaii.edu:80/dods/public_data/FRA-JCOPE2/v','v',[1 1 1 first_num],[inf inf 1 day]); % surface
    save(['../Output/ssh_',num2str(year),'.mat'],'ssh')
    save(['../Output/u_',num2str(year),'.mat'],'u')
    save(['../Output/v_',num2str(year),'.mat'],'v')
    year
end
toc