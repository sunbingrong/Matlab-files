clear;clc;

load('windstress.mat')

%taux = taux*6.11149762494025e-5+0.2659858960164377;
%tauy = tauy*4.5031993553901244e-5+0.10086162354103433;
%for i = 1:size(taux,3)
%    taux(:,:,i) = fliplr(squeeze(taux(:,:,i)));
%    tauy(:,:,i) = fliplr(squeeze(tauy(:,:,i)));
%end

for EB = 290
    nx = 4*(EB-100)+1;
    ny = 221;
    curl = zeros(nx,ny,12);
    %curl_a = zeros(nx,ny,432);
    tx = zeros(ny,nx,12);
    ty = zeros(ny,nx,12);
    load(['case',num2str(EB),'E_topo.mat'])
    % define region and resolution
    lon_area=[100 EB]; lat_area=[-20 35]; resolution = 0.25;
    
    lon_M = 0:resolution:360; lat_M = -90:resolution:90;
    xloc=find(lon_M>=lon_area(1) & lon_M<=lon_area(2));
    yloc=find(lat_M>=lat_area(1) & lat_M<=lat_area(2));
    [xq yq] = meshgrid(lat_M,lon_M);
    [X1,Y1]=meshgrid(lon_M(xloc),lat_M(yloc));
    for i = 1:12
        
        temp = taux(:,:,i);
        %temp = interp2(lat,lon,temp,xq,yq,'linear');
        %temp = temp(xloc,yloc);
        tx(:,:,i) = temp'; % lat*lon
        
        temp = tauy(:,:,i);
        %temp = interp2(lat,lon,temp,xq,yq,'linear');
        %temp = temp(xloc,yloc);
        ty(:,:,i) = temp'; % lat*lon
        
        c = cal_curl(X1,Y1,tx(:,:,i),ty(:,:,i));
        c = c'; % lon*lat
        c(topo==0) = -9.9;
        curl(:,:,i) = c; % lon*lat*time
        
    end
    clear i;
    
    save(['curl_quar_',num2str(EB),'.mat'],'curl');
    
    [im,jm,km] = size(curl);
    fid = fopen([num2str(EB),'E_curl.dat'],'wb');
    for i=1:km
        aa = reshape(curl(:,:,i),[1 im*jm]);
        fwrite(fid,aa,'real*4');
    end
    fclose(fid);
    EB
end
load('curl_quar_290.mat')
month = {'1月';'2月';'3月';'4月';'5月';'6月';'7月';'8月';'9月';'10月';'11月';'12月'};
for i = 1:12
    figure
    [c,h]=contourf(curl(:,:,i)');
    %set(h,'ShowText','on','labelspacing',1000)
    set(h,'ShowText','on','TextList',0)
    saveas(gcf,['curl_',char(month(i)),'.bmp'])
end