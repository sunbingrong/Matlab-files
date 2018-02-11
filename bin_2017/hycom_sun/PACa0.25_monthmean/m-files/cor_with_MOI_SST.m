%% 插值HYCOM数据为同样分辨率, 同样Size的矩阵
clear;clc;

data.lon = load('../Input/hycom.plon');
data.lat  = load('../Input/hycom.plat');

lon = data.lon(1,:);
lat  = flipud(data.lat(:,1));
m   =  length(lon);
n    =  length(lat);
a = find(lon >=119.75 & lon<=289.75);
b = find(lat >=-0.125 & lat <=34.125);

lon_PACa = lon(a(1):a(end));
lat_PACa  = lat(b(1):b(end));

hycom_sst = importdata('../Output/PACa_SST_Clima.mat');

EB =290;

nx = 4*(EB-120)+1;
ny = 4*(34.25-0)+1;
sst = zeros(nx,ny);

% define region and resolution
lon_area=[120 EB]; lat_area=[0 34.25]; resolution = 0.25;

lon_M = lon_area(1):resolution:lon_area(2);
lat_M  = lat_area(1):resolution:lat_area(2);
[xq,yq] = meshgrid(lat_M,lon_M);

temp = hycom_sst;
temp = interp2(lat_PACa,lon_PACa,temp,xq,yq,'linear');
temp = temp(1:length(lon_M),1:length(lat_M));
HYCOM_SST = temp; % turn to lon*lat

%% Correlation of  MOI_STT and th HYCOM PACa_sst

Pac_MOT_SST = importdata('E:\Matlab\bin\bin_2017\MOI_SST\Output\Pac_SST_MOI_Clima.mat');
lon = importdata('E:\Matlab\bin\bin_2017\MOI_SST\Output\MOI_SST_lon.mat');
lat  = importdata('E:\Matlab\bin\bin_2017\MOI_SST\Output\MOI_SST_lat.mat');

lon_f = find(lon==119.875);  lon_l = find(lon==289.875);
lat_f  = find(lat==-0.125);  lat_l  = find(lat ==34.125);
lon_Pac = lon(lon_f:lon_l);
lat_Pac = lat(lat_f:lat_l);


% 剔除 MOI_SST 无效点
m = length(lon_Pac);
n  = length(lat_Pac);

count1=isnan(Pac_MOT_SST);%二维，去掉时间循环

%剔除 HYCOM 无效点
count2=isnan(HYCOM_SST);

count=count1+count2;


%将空间维度降维，记录共同的非nan点 MOI_SST
i=1;
for ix=1:m
    for iy=1:n
        if count(ix,iy)==0
            Y(i)= Pac_MOT_SST(ix,iy);
            i=i+1;
        end
    end
end

%将空间维度降维，记录共同的非nan点 HYCOM_SST
i=1;
for ix=1:m
    for iy=1:n
        if count(ix,iy)==0
            X(i)= HYCOM_SST(ix,iy);
            i=i+1;
        end
    end
end

cor_SST_HYCOM_MOI = corrcoef(X,Y);