function curlz = curlz_myself(lon,lat,u,v)
% Author    Guo Yongqing
% Create on 2015.7.9
% E-mail    aiiky@163.com
% Pass Test of calculating curl of wind stress using Matlab 2013(a)
% Revised on 2015.7.9
% All- Right Reserved
% Usage   Calculate vertical curl of vector (curlz)
% input   vector u,v at position (lon,lat) on Earth, where lon lat in degree
% output  vertical curl of the input vector

Re = 6371000; % Earth Radius 6371 km
[lon,lat] = meshgrid(lon,lat);

[dx_deg,~] = gradient(lon);
dx_dis = dx_deg.*(cosd(lat)*Re)*2*pi/360;

[~,dy_deg] = gradient(lat);
dy_dis = dy_deg.*(2*pi*Re)/360;

[ ~ , du ] = gradient(u);
[ dv , ~ ] = gradient(v);

curlz = dv ./ dx_dis - du ./ dy_dis;

end