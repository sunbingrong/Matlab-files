clear;clc;
year = 2004;
load('../Output/lat_rho.mat');
load('../Output/lon_rho.mat');
load('../Output/z_rho.mat');
nx = 108; ny = 46; nz = 38; nt =12;
for i = 2:nz
    each_depth(i) = z_rho(i) - z_rho(i-1);
end
   each_depth(1) = z_rho(1);
v_sum = zeros(nx,ny,nz,nt); % 120.2E-130.2E 16N-20N
for i = 1:4
    load(['../Output/v_',num2str(year),'.mat']);
    v_sum  =   v_sum + v;
    year = year + 1;
end

v_total = v_sum/i;
y = 18; %18N
delta_x = 6.371e6*cos(y*pi/180)*(0.1*pi/180);
for i = 1:12
    % 122.2E-130.2E 16N-20N 1m-406m
    v1 = reshape(nanmean(v_total(21:41,:,:,i),2),[21 nz]);
    v1(isnan(v1))=0;
    total_trans(i,:) = sum(v1*each_depth'*delta_x);
end
    plot(total_trans/10^6,'-bo')
    xlim([1 12]);
    ylabel('{\its}v')
saveas(gcf,'../Output/roms_trans.jpg');