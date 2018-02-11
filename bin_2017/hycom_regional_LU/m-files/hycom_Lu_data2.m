clear;clc;
latitude  = ncread('../Output/yr0002_0004monthlyMean3D.nc.xyz2','lat');
longitude = ncread('../Output/yr0002_0004monthlyMean3D.nc.xyz2','lon');
depth     = ncread('../Output/yr0002_0004monthlyMean3D.nc.xyz2','dep');
V         = ncread('../Output/yr0002_0004monthlyMean3D.nc.xyz2','Vg');
[nz,nx,ny,nt] = size(V);
% modify the lat & lon value
for i = 1:nx
    longitude(i) = longitude(1) + 0.1*(i-1);
end
for j = 1:ny
    latitude(j) = latitude(1) + 0.1*(j-1);
end
% 121¡ãE-135¡ãE, 2¡ãN-18¡ãN 0m-400m
b = find(latitude>=8.75 & latitude<=18.75); % the range of searching latitude
a = find(longitude==134);  % the range of seaching longitude
for i = 1:12
    v = V(1:13,:,:,i);
    vv = reshape(mean(v,1),[nx ny]);
    [imt,jmt] = size(vv);
    topo = ones(imt,jmt);
    topo(isnan(vv))=0;
    vv(isnan(vv))=0;
    bifurcation(i) = bifurcation_NPacific(a,b,vv,topo,20);
end
c = bifurcation;
plot([1:12],c,'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(¡ãN)');
saveas(gcf,'../Output/HYCOM_Lu_bifur2.jpg');