clear;clc;
latitude  = ncread('../Output/archv.0040_006_00_3zv.nc','Latitude');
longitude = ncread('../Output/archv.0040_006_00_3zv.nc','Longitude');
nx = 256;  ny = 306; nz = 15;
% 95°„E-146°„E, 6°„S-48°„N 0m-400m
for i = 1:12
    sum_v = zeros(nx,ny,nz);
    for day = 30*(i-1)+6:10:30*i-4
        data = ncread(['../Output/archv.0040_',num2str(day,'%03d'),'_00_3zv.nc'],'v');
        sum_v = sum_v + data(:,:,1:nz);
    end
    vv = mean(sum_v,3)/3;
    %vv = sum_v/3;
    %contourf(v')
    [imt,jmt] = size(vv);
    topo = ones(imt,jmt);
    topo(isnan(vv))=0;
    vv(isnan(vv))=0;
    bifurcation(i) = bifurcation_NPacific(vv,topo,10);
end
c = bifurcation;
plot([1:12],c,'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°„N)');
saveas(gcf,'../Output/hycom_bifur.jpg');