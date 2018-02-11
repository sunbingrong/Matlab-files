clear;clc
ncread('../Output/roms0184.nc','v');
n = length(depth);
each_depth = zeros(1,n);
for i = 2:n
     each_depth(i)=depth(i)-depth(i-1);
end
     each_depth(1) = depth(1);
     save each_depth.mat each_depth