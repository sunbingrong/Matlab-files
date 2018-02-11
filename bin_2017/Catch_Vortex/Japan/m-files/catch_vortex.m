clear;clc
year = 1993;
year_month_day_0 = [year 01 01]; year_month_day_1 = [year 12 31];
date_num_0 = datenum(year_month_day_0);
date_num_1 = datenum(year_month_day_1);
lat = importdata('../Output/lat.mat'); lon = importdata('../Output/lon.mat');
alpha = zeros(length(lon),length(lat));
for year = 1993
    u   = importdata(['../Output/u_',num2str(year),'.mat']);   u   = reshape(u,length(lon),length(lat),[]);
    v   = importdata(['../Output/v_',num2str(year),'.mat']);   v   = reshape(v,length(lon),length(lat),[]);
    ssh = importdata(['../Output/ssh_',num2str(year),'.mat']); ssh = reshape(ssh,length(lon),length(lat),[]);
end
month = 1;
u = mean(u(:,:,1:31),3); v = mean(v(:,:,1:31),3); ssh = mean(ssh(:,:,1:31),3);
for i = 2:length(lon)-1
    for j = 2:length(lat)-1
        alpha(i,j) = (abs(ssh(i+1,j,month)-ssh(i,j,month)) - abs(ssh(i,j,month)-ssh(i-1,j,month)))...
            /(abs(ssh(i+1,j,month)+ssh(i,j,month))+abs(ssh(i,j,month)+ssh(i-1,j,month)));
    end
end
rot_data = curlz_myself(lon,lat,u(:,:,month)',v(:,:,month)');
div_data = divergence_myself(lon,lat,u(:,:,month)',v(:,:,month)');
rou = (div_data.*div_data)./((div_data.*div_data)+(rot_data.*rot_data));
xishu = alpha'.*rou;
xishu(xishu<=0.01)=1;
subplot(1,2,1)
contourf(ssh')
subplot(1,2,2)
contourf(xishu)