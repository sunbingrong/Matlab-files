% calculate curvature vorticity
clear;clc
load ('../Input/map3.mat');
load ('../Input/topo.mat');
lon = 100:200; lat = 10:60;
Wind_west = 170; Wind_east = 190;
Wind_start_index = Wind_west - lon(1) + 1;
Wind_end_index   = Wind_east - lon(1) + 1;
nx = length(lon); ny = length(lat);
taux = zeros(nx,ny,12); tauy = zeros(nx,ny,12);
[X,Y]=meshgrid(lon,lat);
temp_x = zeros(nx,ny); temp_y = zeros(nx,ny);
% for i = Wind_start_index:Wind_end_index
%     for j = 1:ny
%         taux(i,j) = 0.2*exp(-(1d5*(lat(j)-midlat)).^2/2/(5d5).^2);
%     end
% end
mid = 20:31;  % wind stress curl zero lines location latitude
for mon = 1:12
    if (2*mid(mon)>51)
        for j = 1:51
            a = 1/2*pi/(mid(mon)-1);
            b = -10*1/2*pi/(mid(mon)-1);
            taux(:,j,mon) = -0.2*sin(a*lat(j)+b);
        end
    else
        for j = 1:2*mid(mon)-1
            a = 1/2*pi/(mid(mon)-1);
            b = - a;
            taux(:,j,mon) = -0.2*sin(a*j+b);
        end
        for j = 2*mid(mon):51
            a = 0.2/(2*mid(mon)-51);
            b = -a*2*mid(mon);
            taux(:,j,mon) = a*j+b;
        end
    end
%    taux(:,mid(mon)-1:mid(mon)+1,mon) = 0;
    temp_x = taux(:,:,mon);
    temp_y = tauy(:,:,mon);
    cav    = cal_curl(X,Y,temp_x',temp_y');
    cav(topo'==0)=-9.9;
    curl_mon(:,:,mon) = cav'; 
    
end

for year = 1:20
    for mon = 1:12
        curl(:,:,12*(year-1)+mon) = curl_mon(:,:,mon);
    end
end

%colorbar;
%pcolor(X,Y,cav);
%colormap(map3);

%cav(topo==0)=-9.9;
[im,jm,km] = size(curl);
fid = fopen('../Input/curl.dat','wb');
for i=1:km
    aa = reshape(curl(:,:,i),[1 im*jm]);
    fwrite(fid,aa,'real*4');
end
fclose(fid);

save('../Input/taux.mat','taux');