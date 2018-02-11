clc; clear; close all

load('../Input/topo.mat'); % lon*lat

pi = 4*atan(1);
omega = 2*pi/86400;
g_prime = 0.03;
H = 350;

lon_area=[100 200]; lat_area=[10 60]; resolution = 1; % lon*lat 101*51
lon = lon_area(1):resolution:lon_area(2);
lat = lat_area(1):resolution:lat_area(2);
nx = length(lon); ny = length(lat);
cr = zeros(nx,ny);
for j = 1:ny
    y = lat(j);
    f = 2*omega*sin(y*pi/180);
    beta = 2*omega*cos(y*pi/180)/6.371e6;
    cr(:,j) = -beta*g_prime*H/(f*f);
end
[im,jm] = size(cr);
max_cr=max(cr(1,:));
min_cr=min(cr(1,:));
%for n = 1:jm
%    cr(:,n) = 1/10/(max_cr-min_cr)*cr(:,n)+(max_cr-2*min_cr)/10/(max_cr-min_cr);
%end
cr(topo==0) = -9.9;

%cr(cr<-9)=NaN;
%[c,d] = contour(100:0.25:290,5:0.25:35,cr',0.01:0.01:0.07);colorbar
%clabel(c,d,'manual')

fid = fopen('../Input/cr.dat','wb');
for j = 1:jm
    fwrite(fid,cr(:,j),'real*4');
end
fclose(fid);
