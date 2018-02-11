clear;clc
load('../Output/lon.mat');load('../Output/lat.mat');load('../Output/depth.mat');
V_temp = importdata('../Output/Up300/HYCOM_V_001.mat');
[nx,ny] = size(V_temp);
sum_V = zeros(nx,ny,12);
n = 204;
for i = 1:n
    V_temp = importdata(['../Output/Up400/HYCOM_V_',num2str(i,'%03d'),'.mat']);
    n_yushu = mod(i,12);
    if n_yushu == 0
        n_month = 12;
    else
        n_month = n_yushu;
    end
    sum_V(:,:,n_month) = sum_V(:,:,n_month)  + V_temp;
end
%the north-ward velocity Hycom from net
V_Hycom_net = sum_V/(n/12);
a1=find(lon>=100 & lon<=290);
b1=find(lat>=-20 & lat<=35);    % a b the domain of need_data
v_lon = lon(a1);
v_lat = lat(b1);
% 100¡ãE - 290¡ãE, 20¡ãS-35¡ãN
b = find(v_lat>=8.75 & v_lat<=18.75); % the range of searching latitude
a = find(v_lon==134);  % the range of seaching longitude
for i = 1:12
    vv = V_Hycom_net(:,:,i);
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