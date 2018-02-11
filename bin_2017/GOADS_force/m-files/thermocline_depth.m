clear;clc
% calculate the thermal_depth
% sigma :lon*lat*time*depth
% u & v :lon*lat*time*depth
% read all the data
load('../Output/GOADS_salt/GOADS_salt_198001.mat');load('../Output/GOADS_depth.mat');
load('../Output/sigma.mat')
%load('../Output/u.mat');  load('../Output/v.mat');

%%%%-----------calculate the thermal_depth-----------------%%%%
[nx,ny,nz] = size(salt); depth = GOADS_lev;
location = ones(nx,ny,12);
for month = 1:12
    sigma_temp = reshape(sigma(:,:,:,month),[nx,ny,nz]);
    for i = 1:nx
        for j = 1:ny
            for k = 1:nz
                if (sigma_temp(i,j,k)<26.5) && ((sigma_temp(i,j,k+1)>=26.5) || sigma_temp(i,j,k+2)>=26.5)
                    location(i,j,month) = k+1;
                    thermal_depth(i,j,month) = depth(k+1);
                end
            end
        end
    end
    month
end
clear i j k month
% calculate the u&v
load('../Output/GOADS_u_month.mat');load('../Output/GOADS_v_month.mat');
[nx,ny,nz,nt] = size(GOADS_u_monthly);
GOADS_upper_u = zeros(nx,ny,nt);
GOADS_upper_v = zeros(nx,ny,nt);
for month = 1:nt
    for i = 1:nx-1
        for j = 1:ny
            GOADS_upper_u(i,j,month) = nanmean(GOADS_u_monthly(i,j,1:location(i,j,month),month));
            GOADS_upper_v(i,j,month) = nanmean(GOADS_v_monthly(i,j,1:location(i,j,month),month));
        end
    end
    month
end
save('../Output/GOADS_upper_u.mat','GOADS_upper_u');
save('../Output/GOADS_upper_v.mat','GOADS_upper_v');
save('../Output/therm_depth.mat','thermal_depth');