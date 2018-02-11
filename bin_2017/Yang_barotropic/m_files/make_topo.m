clear;clc
lon = 100:200;
lat = 10:60;
nx = length(lon); ny = length(lat);
topo = ones(nx,ny);
topo(1,:) = 0; topo(end,:) = 0;
topo(:,1) = 0; topo(:,end) = 0;
save('../Input/topo.mat','topo');
topo = reshape(topo,[nx*ny 1]);
save('../Input/topo.dat','topo','-ascii');
