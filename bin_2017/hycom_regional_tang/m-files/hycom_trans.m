clear;clc;
load('each_depth.mat');
y = 18; %18N
delta_x = 6.371e6*cos(y*pi/180)*(0.2*pi/180);
latitude = ncread('../Output/archv.0040_006_00_3zv.nc','Latitude');
nx = 256;  ny = 306; nz = 12;
for i = 1:12
    sum_v = zeros(nx,ny,nz);
    for day = 30*(i-1)+6:10:30*i-4
        data = ncread(['../Output/archv.0040_',num2str(day,'%03d'),'_00_3zv.nc'],'v');
        v_total = data(:,:,2:13);  % 95°„E-146°„E, 6°„S-48°„N 10m-400m
        v_total(isnan(v_total))=0;
        sum_v = sum_v + v_total;
    end
    vv = sum_v/3;
    v1 = vv(136:176,111:131,:); % 122E-130E  16N-20N
    %v1 = v_total(136:176,121,:); % 122E-130E  16N-20N
    v2 = reshape(mean(v1,2),[41 12]);
    trans = v2(1:40,:)*depth';
    total_trans(i,:) = sum(trans)*delta_x;
    total_trans = smooth(total_trans,6,'loess');
    plot(total_trans,'-ro')
    xlim([1 12])
end
saveas(gcf,'../Output/hycom_trans.jpg');