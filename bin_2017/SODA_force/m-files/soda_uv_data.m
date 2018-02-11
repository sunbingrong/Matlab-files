clear;clc
% sigma :lon*lat*time*depth
% u & v :lon*lat*time*depth
% read all the data
load('../Output/longitude.mat'); load('../Output/latitude.mat'); load('../Output/depth.mat');
load('../Output/sigma.mat')
load('../Output/u.mat');  load('../Output/v.mat');
% calculate the soda_bc
%calculate the h_depth
nx = length(lon); ny = length(lat); nt = 12; nz = length(depth);
for month = 1:12
    sigma_temp = reshape(sigma(:,:,month,:),[nx,ny,nz]);
    for i = 1:nx
        for j = 1:ny
            for k = 1:nz
                if( (sigma_temp(i,j,k)<26.5) && (sigma_temp(i,j,k+1)>=26.5))
                    location(i,j,month) = k+1;
                    h(i,j,month) = depth(k+1);
                end
            end
        end
    end
    month
end
% calculate the u/v
u_mean = zeros(nx,ny,nt);
v_mean = zeros(nx,ny,nt);
for month = 1:12
    for i = 1:nx
        for j = 1:ny
            u_mean(i,j,month) = mean(u(i,j,month,1:location(i,j,month)));
            v_mean(i,j,month) = mean(v(i,j,month,1:location(i,j,month)));
        end
    end
    month
end
save('../Output/u_mean.mat','u_mean');save('../Output/v_mean.mat','v_mean');
save('../Output/upper_H.mat','h');