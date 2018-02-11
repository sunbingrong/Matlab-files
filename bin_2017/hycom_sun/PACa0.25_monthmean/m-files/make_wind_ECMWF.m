clear;clc;

ncid = netcdf.open('../Input/ERA_Interim_tau_uv_1979-2014_monthly.nc','NOWRITE');
varid = netcdf.inqVarID(ncid,'longitude');
lon = netcdf.getVar(ncid,varid,'double');
varid = netcdf.inqVarID(ncid,'latitude');
lat = netcdf.getVar(ncid,varid,'double');  lat = -lat;
varid = netcdf.inqVarID(ncid,'iews');
taux = netcdf.getVar(ncid,varid,'double');
varid = netcdf.inqVarID(ncid,'inss');
tauy = netcdf.getVar(ncid,varid,'double');
netcdf.close(ncid);

taux = taux*6.11149762494025e-5+0.2659858960164377;
tauy = tauy*4.5031993553901244e-5+0.10086162354103433;
for i = 1:size(taux,3)
    taux(:,:,i) = fliplr(squeeze(taux(:,:,i)));
    tauy(:,:,i) = fliplr(squeeze(tauy(:,:,i)));
end

for EB = 140
    nx = 4*(EB-100)+1;
    ny = 101;
    curl = zeros(nx,ny,432);
    %curl_a = zeros(nx,ny,432);
    tx = zeros(ny,nx,432);
    ty = zeros(ny,nx,432);
    load(['../Input/topo_',num2str(EB),'E.mat'])
    % define region and resolution
    lon_area=[100 EB]; lat_area=[10 35]; resolution = 0.25;
    
    lon_M = 0:resolution:360; lat_M = -90:resolution:90;
    xloc=find(lon_M>=lon_area(1) & lon_M<=lon_area(2));
    yloc=find(lat_M>=lat_area(1) & lat_M<=lat_area(2));
    [xq yq] = meshgrid(lat_M,lon_M);
    [X1,Y1]=meshgrid(lon_M(xloc),lat_M(yloc));
    for i = 1:432
        
        temp = taux(:,:,i);
        temp = interp2(lat,lon,temp,xq,yq,'linear');
        temp = temp(xloc,yloc);
        tx(:,:,i) = temp'; % lat*lon
        
        temp = tauy(:,:,i);
        temp = interp2(lat,lon,temp,xq,yq,'linear');
        temp = temp(xloc,yloc);
        ty(:,:,i) = temp'; % lat*lon
        
    end
    clear i;
    %平均化，形成季节循环的风场
    temp1 = zeros(ny,nx,432); temp2 = zeros(ny,nx,432);
    for i = 1:12
        sum1 = 0; sum2 = 0;
        for year = 1:36
            sum1 = sum1 + tx(:,:,12*(year-1)+i);
            sum2 = sum2 + ty(:,:,12*(year-1)+i);
        end
        temp1(:,:,i) = sum1/36;
        temp2(:,:,i) = sum2/36;
    end
    
    for n = 1:12
        for i = n:12:(432-12+n)
            tx(:,:,i) = temp1(:,:,n);
            ty(:,:,i) = temp2(:,:,n);
        end
    end
    % 计算风应力旋度
%     tx_a = zeros(ny,nx,432); ty_a = zeros(ny,nx,432); % lat*lon 
    for month = 1:432
%         tx_a(:,:,month) = tx(:,:,month) - mean(tx,3);
%         ty_a(:,:,month) = ty(:,:,month) - mean(ty,3);
        c = cal_curl(X1,Y1,tx(:,:,month),ty(:,:,month));
        c = c'; % lon*lat
        c(topo==0) = -9.9;
        curl(:,:,month) = c; % lon*lat*time
    end
    
    % save(['/home/user/sbr/sbr/box_Vorticity/Output/curl_ECMWF_',num2str(EB),'.mat'],'curl');
    
    [im,jm,km] = size(curl);
    fid = fopen(['../Input/',num2str(EB),'E_curl.dat'],'wb');
    for i=1:km
        aa = reshape(curl(:,:,i),[1 im*jm]);
        fwrite(fid,aa,'real*4');
    end
    fclose(fid);
    EB
end

% t1=taux(148:322,135:200,300);
% t2=tauy(148:322,135:200,300);
% tx=t1';ty=t2';
% [X1,Y1]=meshgrid(lon(148:322),lat(135:200));
% c=cal_curl(X1,Y1,tx,ty);
