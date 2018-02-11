function curldata=cal_curl(X,Y,u,v)
% cal_curl   calculate curl of vector
%================================================================
% cal_curl  Date: 2010/11/7 22:00
%           Copyright (C) zhchen
%
% USAGE:  curldata=cal_curl(X,Y,u,v)
%---------------------------------------------------------------
%-----     X,Y should have the same size of u, v
%-----     u v (lat,lon)  format
%-----     missing value should be nan!!!

[jm,im]=size(X);
curldata=zeros(jm,im);
%---dis of 1 degree
dis1d=pi/180.*6.371e6;
%---0E,-90S as the reference point
disY=(Y+90)*dis1d;
for j=1:jm
disX(j,:)=(X(j,:)-0)*dis1d*cosd(Y(j,1));
end
[curldata, CAV]= curl(disX,disY,u,v);

