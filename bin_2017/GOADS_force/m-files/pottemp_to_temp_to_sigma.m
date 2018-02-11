clear;clc
% temperature calculating
% so: lat*lon*time*depth (salinity)
% to: lat*lon*time*depth (potential temperature)
load('../Output/GOADS_salt_month.mat');load('../Output/GOADS_pottemp_month.mat');
load('../Output/GOADS_lat.mat');load('../Output/GOADS_depth.mat');
so  = GOADS_salt_monthly*1000;
to  = GOADS_pottemp_monthly-273.15;   % K temperature  = °„C + 273.15
lat = GOADS_lat;
depth = GOADS_lev;
k=0;
disp(['Progress: temperatue calculating']);
for t = 1:size(to,4) %time
    for j=1:size(to,2);%lat;
        for z=1:size(to,3);%depth
            cto=squeeze(to(:,j,z,t));
            cso=squeeze(so(:,j,z,t));
            temp(:,j,z,t)=sw_temp(cso,cto,sw_pres(depth(z)*ones(size(cso)),lat(j)),sw_pres(depth(1)*ones(size(cso)),lat(j)));
        end
        k=k+1;
    end
    clear cto cso
    t
end
clear so to

% sigma calculating
%=========== cal sigma & rou =====================
% so: lat*lon*time*depth (salinity)
% to: lat*lon*time*depth (temperature)
so = GOADS_salt_monthly*1000;
to = temp;
k=0;
disp(['Progress: sigma calculating']);
for t=1:size(to,4); %time;
    for j=1:size(to,2);%lat;
        for z=1:size(to,3);%depth
            cto=squeeze(to(:,j,z,t));
            cso=squeeze(so(:,j,z,t));
            sigma(:,j,z,t)=sw_pden(cso,cto,sw_pres(depth(z)*ones(size(cso)),lat(j)),sw_pres(depth(1)*ones(size(cso)),lat(j)));
            rou(:,j,z,t)=sw_dens(cso,cto,sw_pres(depth(z)*ones(size(cso)),lat(j)));
        end
        k=k+1;
    end
    clear cto cso
    t
end
clear so to
sigma=sigma-1000*ones(size(sigma));
save('../Output/sigma.mat','sigma');