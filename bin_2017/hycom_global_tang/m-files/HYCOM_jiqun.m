clear;clc;
v = importdata('../Output/V.mat');
[nx,ny,nt] = size(v);
a=find(lon=100 & lon<=290);
% 95¡ãE-146¡ãE, 6¡ãS-48¡ãN 0m-400m
for i = 1:12

    vv = v(:,:,i);
    [imt,jmt] = size(vv);
    topo = ones(imt,jmt);
    topo(vv==0)=nan;
    
    vv(isnan(vv))=0;
    bifurcation(i) = bifurcation_NPacific(vv,topo,8);
end
 c = bifurcation;
plot([1:12],c,'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(¡ãN)');
saveas(gcf,'../Output/hycom_bifur.jpg');