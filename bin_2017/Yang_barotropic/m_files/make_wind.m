clear;clc;
nx=761;
ny=101;
t=120;
taux=zeros(nx,ny,t);
tauy=zeros(nx,ny,t);
taux(:,1:21,:) = 1;taux(:,end-12:end,:) = -1;
%taux = taux*6.11149762494025e-5+0.2659858960164377;
%tauy = tauy*4.5031993553901244e-5+0.10086162354103433;
for i = 1:size(taux,3)
    taux(:,:,i) = fliplr(squeeze(taux(:,:,i)));
    tauy(:,:,i) = fliplr(squeeze(tauy(:,:,i)));
end

for EB = 290
    curl = zeros(4*(EB-100)+1,101,120);
    load(['/home/user/sbr/sbr/Yang_barotropic/Input/topo_',num2str(EB),'E.mat'])
    % define region and resolution
    lon_area=[100 EB]; lat_area=[10 35]; resolution = 0.25;
    
    lon_M = 0:resolution:360; lat_M = -90:resolution:90;
    xloc=find(lon_M>=lon_area(1) & lon_M<=lon_area(2));
    yloc=find(lat_M>=lat_area(1) & lat_M<=lat_area(2));
    [xq yq] = meshgrid(lat_M,lon_M);
    [X1,Y1]=meshgrid(lon_M(xloc),lat_M(yloc));
    for i = 1:120
        
        temp = taux(:,:,i);
        temp = interp2(lat,lon,temp,xq,yq,'linear');
        temp = temp(xloc,yloc);
        tx = temp'; % lat*lon
        
        temp = tauy(:,:,i);
        temp = interp2(lat,lon,temp,xq,yq,'linear');
        temp = temp(xloc,yloc);
        ty = temp'; % lat*lon
        
        c = cal_curl(X1,Y1,tx,ty);
        c = c'; % lon*lat
        c(topo==0) = -9.9;
        curl(:,:,i) = c; % lon*lat*time
        
    end
    
    % for i = 1:12
    %     sum = 0;
    %     for year = 1:36
    %         sum = sum + curl(:,:,12*(year-1)+i);
    %      end
    %     temp_curl(:,:,i) = sum/36;
    % end
    % for n = 1:12
    %     for i = n:12:(432-12+n)
    %         curl_monthly(:,:,i) = temp_curl(:,:,n);
    %     end
    % end
    
    %save(['/home/user/sbr/sbr/box_Vorticity/Output/curl_ECMWF_',num2str(EB),'.mat'],'curl');
    
    [im,jm,km] = size(curl);
    fid = fopen(['/home/user/sbr/sbr/Yang_barotropic/Input/',num2str(EB),'E_curl.dat'],'wb');
    for i=1:km
        aa = reshape(curl(:,:,i),[1 im*jm]);
        fwrite(fid,aa,'real*4');
    end
    fclose(fid);
    EB
end