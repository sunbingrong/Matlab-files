clc; clear; close all
for EB=290
    
    load(['../Input/topo_',num2str(EB),'E.mat']) % lon*lat
    
    pi = 4*atan(1);
    omega = 2*pi/86400;
    g_prime = 0.03;
    H = 300;
    
    lon_area=[100 EB]; lat_area=[10 35]; resolution = 0.25; % lon*lat 761*101
    lat = lat_area(1):resolution:lat_area(2);
    cr = zeros(4*(EB-100)+1,101);
    for j = 1:length(lat)
        y = lat(j);
        f = 2*omega*sin(y*pi/180);
        beta = 2*omega*cos(y*pi/180)/6.371e6;
        cr(:,j) = -beta*g_prime*H/(f*f);
    end
    [im,jm] = size(cr);
    max_cr=max(cr(1,:));
    min_cr=min(cr(1,:));
%     for n = 1:jm
%         cr(:,n) = 1/10/(max_cr-min_cr)*cr(:,n)+(max_cr-2*min_cr)/10/(max_cr-min_cr);
%     end
    cr(topo==0) = -9.9;
    
    %cr(cr<-9)=NaN;
    %[c,d] = contour(100:0.25:290,5:0.25:35,cr',0.01:0.01:0.07);colorbar
    %clabel(c,d,'manual')
    
    
%     fid = fopen(['../Input/',num2str(EB),'E_cr.dat'],'wb');
%     for j = 1:jm
%         fwrite(fid,cr(:,j),'real*4');
%     end
%     fclose(fid);
    EB
end
