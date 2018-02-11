%% 插值Argo数据为同样分辨率, 同样Size的矩阵
clear;clc;
lon       =  ncread('E:\Matlab\bin\bin_2017\Argo_S_T\Input\Clima_S_T_ArgoData.nc','LONGITUDE');
lat        =  ncread('E:\Matlab\bin\bin_2017\Argo_S_T\Input\Clima_S_T_ArgoData.nc','LATITUDE');
temp   =  ncread('E:\Matlab\bin\bin_2017\Argo_S_T\Input\Clima_S_T_ArgoData.nc','TEMP');
salt      =  ncread('E:\Matlab\bin\bin_2017\Argo_S_T\Input\Clima_S_T_ArgoData.nc','SALT');
Level   = ncread('E:\Matlab\bin\bin_2017\Argo_S_T\Input\Clima_S_T_ArgoData.nc','LEVEL');
lon = double(lon); lat = double(lat); Level = double(Level);
% Surface
sst_level = 1; sss_level = 1;

sst = temp(:,:,sst_level); sss = salt(:,:,sss_level);

EB =290;

% define region and resolution
lon_area=[120 EB]; lat_area=[0 34.25]; resolution = 0.25;

lon_M = 0:resolution:360; lat_M = -90:resolution:90;
xloc = find(lon_M>=lon_area(1) & lon_M<=lon_area(2));
yloc = find(lat_M>=lat_area(1) & lat_M<=lat_area(2));
[xq, yq] = meshgrid(lat_M,lon_M);
[X1,Y1] = meshgrid(lat_M(yloc),lon_M(xloc));
%插值SST
middle = sst;
middle = interp2(lat,lon,middle,xq,yq,'linear');
middle = middle(1:length(lon_M),1:length(lat_M));
Pac_SST_Argo = middle(xloc,yloc); % turn to lon*lat, Pacific Ocean

%插值SSS
middle = sss;
middle = interp2(lat,lon,middle,xq,yq,'linear');
middle = middle(1:length(lon_M),1:length(lat_M));
Pac_SSS_Argo = middle(xloc,yloc); % turn to lon*lat, Pacific Ocean

%% 数据HYCOM数据为同样分辨率, 同样Size的矩阵

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
hycom_sss = importdata('../Output/PACa_SSS_Clima.mat');

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

temp = hycom_sss;
temp = interp2(lat_PACa,lon_PACa,temp,xq,yq,'linear');
temp = temp(1:length(lon_M),1:length(lat_M));
HYCOM_SSS = temp; % turn to lon*lat

%% Correlation of  Argo_SST and  HYCOM PACa_sst 

[m,n] = size(HYCOM_SST);

% 剔除 HYCOM_SST 无效点
count1=isnan(HYCOM_SST);%二维，去掉时间循环

%剔除 Argo_SST 无效点
count2=isnan(Pac_SST_Argo);

count=count1+count2;


%将空间维度降维，记录共同的非nan点 HYCOM_SST
i=1;
for ix=1:m
    for iy=1:n
        if count(ix,iy)==0
            Y(i)= HYCOM_SST(ix,iy);
            i=i+1;
        end
    end
end

%将空间维度降维，记录共同的非nan点 Pac_SST_Argo
i=1;
for ix=1:m
    for iy=1:n
        if count(ix,iy)==0
            X(i)= Pac_SST_Argo(ix,iy);
            i=i+1;
        end
    end
end

cor_SST_HYCOM_Argo = corrcoef(X,Y);

 %% Correlation of  Argo_SSS and  HYCOM PACa_sss
 [m,n] = size(HYCOM_SSS);

% 剔除 HYCOM_SST 无效点
count1=isnan(HYCOM_SSS);%二维，去掉时间循环

%剔除 Argo_SST 无效点
count2=isnan(Pac_SSS_Argo);

count=count1+count2;


%将空间维度降维，记录共同的非nan点 HYCOM_SST
i=1;
for ix=1:m
    for iy=1:n
        if count(ix,iy)==0
            Y(i)= HYCOM_SSS(ix,iy);
            i=i+1;
        end
    end
end

%将空间维度降维，记录共同的非nan点 Pac_SST_Argo
i=1;
for ix=1:m
    for iy=1:n
        if count(ix,iy)==0
            X(i)= Pac_SSS_Argo(ix,iy);
            i=i+1;
        end
    end
end

cor_SSS_HYCOM_Argo = corrcoef(X,Y);