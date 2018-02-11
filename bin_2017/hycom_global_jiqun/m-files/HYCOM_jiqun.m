clear;clc;
v = importdata('../Output/V.mat');
v_lon = importdata('../Output/v_lon.mat');
v_lat = importdata('../Output/v_lat.mat');
[nx,ny,nt] = size(v);
% 100¡ãE - 290¡ãE, 20¡ãS-35¡ãN
b = find(v_lat>=8.75 & v_lat<=18.75); % the range of searching latitude 
a = find(v_lon==130);  % the range of seaching longitude
for i = 1:12
    vv = v(:,:,i);
    [imt,jmt] = size(vv);
    topo = ones(imt,jmt);
    topo(isnan(vv))=0;
    vv(isnan(vv))=0;
    bifurcation(i) = bifurcation_NPacific(a,b,vv,topo,25);
end
 c = bifurcation;
plot([1:12],c,'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(¡ãN)');
saveas(gcf,'../Output/hycom_jiqun_bifur.jpg');