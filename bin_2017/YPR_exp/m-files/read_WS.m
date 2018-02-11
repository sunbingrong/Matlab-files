clear;clc

load('../Input/WS1900-2010.mat');load('../Input/case290E_topo.dat');
lat  = lat_15model;
lon  = lon_15model;
topo = reshape(case290E_topo,[761 221]);
topo(topo==0)=nan;
EB = 290;

% define region and resolution
lon_area=[100 EB]; lat_area=[-20 35]; resolution = 0.25;

lon_M = 0:resolution:360; lat_M = -90:resolution:90;
xloc=find(lon_M>=lon_area(1) & lon_M<=lon_area(2));
yloc=find(lat_M>=lat_area(1) & lat_M<=lat_area(2));
[xq,yq] = meshgrid(lat_M,lon_M);
[X1,Y1] = meshgrid(lon_M(xloc),lat_M(yloc));

taux = zeros(length(xloc),length(yloc),12*110);
tauy = zeros(length(xloc),length(yloc),12*110);
for yr = 1:110
    for month = 1:12
        temp = taux_15model(:,:,12*(yr-1)+month);
        temp = interp2(lat,lon,temp,xq,yq,'linear');
        temp = temp(xloc,yloc);
        temp((isnan(temp) + (topo==1))==2)=0;
        tx   = temp; % lon*lat
        tx(isnan(topo)) = nan;
        taux(:,:,12*(yr-1)+month) = tx;
        
        temp = tauy_15model(:,:,12*(yr-1)+month);
        temp = interp2(lat,lon,temp,xq,yq,'linear');
        temp = temp(xloc,yloc);
        temp((isnan(temp) + (topo==1))==2)=0;
        ty   = temp; % lon*lat
        ty(isnan(topo)) = -9.9;
        tauy(:,:,12*(yr-1)+month) = ty;
        
        %c = cal_curl(X1,Y1,tx,ty);
        %c = c'; % lon*lat
        %c(topo==0) = -9.9;
        %curl(:,:,12*(yr-1)+month) = c; % lon*lat*time
    end
    yr
end

topo = reshape(topo,[length(xloc)*length(yloc) 1]);
save('../Input/soda_topo.dat','topo','-ascii');
[im,jm,km] = size(taux);


fid_aa = fopen(['../Input/',num2str(EB),'E_taux.dat'],'wb');
for i=1:km
    aa = reshape(taux(:,:,i),[1 im*jm]);
    fwrite(fid_aa,aa,'real*4');
end

fid_bb = fopen(['../Input/',num2str(EB),'E_tauy.dat'],'wb');
for i=1:km
    bb = reshape(tauy(:,:,i),[1 im*jm]);
    fwrite(fid_bb,bb,'real*4');
end

fclose(fid_aa);fclose(fid_bb);