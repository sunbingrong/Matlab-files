clear;clc
load('../Input/longitude.mat');load('../Input/latitude.mat');
load('../Input/depth.mat');
load('../Input/u.mat');load('../Input/v.mat');load('../Input/ssh.mat');
alpha = zeros(length(lon),length(lat));
for month = 1
    for i = 2:length(lon)-1
        for j = 2:length(lat)-1
            alpha(i,j) = (abs(ssh(i+1,j,month)-ssh(i,j,month)) - abs(ssh(i,j,month)-ssh(i-1,j,month)))...
                         /(abs(ssh(i+1,j,month)+ssh(i,j,month))+abs(ssh(i,j,month)+ssh(i-1,j,month)));
        end
    end
    rot_data = curlz_myself(lon,lat,u(:,:,month,1)',v(:,:,month,1)');
    div_data = divergence_myself(lon,lat,u(:,:,month,1)',v(:,:,month,1)');
    rou = (div_data.*div_data)./((div_data.*div_data)+(rot_data.*rot_data));
    xishu = alpha'.*rou;
end