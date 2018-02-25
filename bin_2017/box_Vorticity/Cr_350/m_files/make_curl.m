clear;clc

load('../Input/windstress.mat')

for EB = 290
    
    curl = zeros(4*(EB-100)+1,101,432);
    load(['../Input/topo_',num2str(EB),'E.mat']) % lon*lat
    
    % define region and resolution
    lon_area=[100 EB]; lat_area=[10 35]; resolution = 0.25;
    
    lon_M = 100:resolution:290; lat_M = -20:resolution:40;
    xloc=find(lon_M>=lon_area(1) & lon_M<=lon_area(2));
    yloc=find(lat_M>=lat_area(1) & lat_M<=lat_area(2));
    [xq yq] = meshgrid(lat_M,lon_M);
    [X1,Y1] = meshgrid(lon_M(xloc),lat_M(yloc));
    for year = 1:36
        for month = 1:12
            temp = taux(:,:,month);
            temp = temp(xloc,yloc);
            tx   = temp'; % lat*lon
            
            temp = tauy(:,:,month);
            temp = temp(xloc,yloc);
            ty   = temp'; % lat*lon
            
            c = cal_curl(X1,Y1,tx,ty);
            c = c'; % lon*lat
            c(topo==0) = -9.9;
            curl(:,:,month+(year-1)*12) = c; % lon*lat*time
        end
    end
    
    [im,jm,km] = size(curl);
    fid = fopen(['../Input/',num2str(EB),'E_curl.dat'],'wb');
    for i=1:km
        aa = reshape(curl(:,:,i),[1 im*jm]);
        fwrite(fid,aa,'real*4');
    end
    fclose(fid);
    EB
end
