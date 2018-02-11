%% 计算风应力旋度 看一下线性增加风应力的大小风应力旋度零线的位置会不会变化  结果证实不变
fid=fopen('ERAs3_mean_1959_2009.dat','rb');
b=fread(fid,[761,241*2],'real*4');
meantaux=b(:,1:241);
meantauy=b(:,242:482);

meantaux(meantaux<-9)=nan;
meantauy(meantauy<-9)=nan;

lat=-20:0.25:40;
lon=100:0.25:290;
[X Y]=meshgrid(lon,lat);
curldata=cal_curl(X,Y,meantaux',meantauy');

figure
m_proj('Gall-peters','lon',[100 290],'lat',[-20 40]);
hold on
m_contourf(X,Y,curldata);
m_coast('patch',[.8 .8 .8]);
hold on
%% 
% clc;clear all;close all;
%--------------------------MAKE WIND DATA monmean totalmonth=12
fid=fopen('ERAs3_monmean_1959_2009.dat','rb');
b=fread(fid,[761,241*24],'real*4');%20E-70W  45S-40N
fclose(fid);
for month=1:12;
tauxi(:,:,month)=b(:,(2*month-2)*241+1:(2*month-1)*241);
tauyi(:,:,month)=b(:,(2*month-1)*241+1:2*month*241);
end

% %--------------------------MAKE WIND DATA monthly totalmonth=612
% fid=fopen('ERAs3_monthly_1959_2009.dat','rb');
% b=fread(fid,[761,241*1224],'real*4');%20E-70W  45S-40N
% fclose(fid);
% for month=1:720;
% tauxi(:,:,month)=b(:,(2*month-2)*241+1:(2*month-1)*241);
% tauyi(:,:,month)=b(:,(2*month-1)*241+1:2*month*241);
% end