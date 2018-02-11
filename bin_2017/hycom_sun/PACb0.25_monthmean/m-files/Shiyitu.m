% 看mean_H 的场
clear;clc
load map3;
rang = {'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E','250E','260E'};
for EB = 290
    figure;
    load(['../Output/case_H_NP_',num2str(EB),'E.mat']);
    nx = (EB-120)*4+1;
    mean_H = H_NP + 350;
    % 126E-136E,10N-18N 找到分叉点对于的h_a_mean的大小
    h_notice = mean(H_NP(25:65,29:61),1);
    h_a_mean = mean(h_notice);
    lon = 120:1/4:EB;
    lat = 3:1/4:21;
    [X,Y]=meshgrid(lon,lat);
    m_proj('miller','lon',[120 EB],'lat',[3 21]);
    m_proj('Equidistant Cylindrical','lon',[120 EB],'lat',[3 21]);
    m_grid('linestyle','none','fontsize',15);
    m_coast('patch',[.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[3]);
    hold on
    [c,h] = m_contourf(X,Y,mean_H');
    clabel(c,h,'manual','fontsize',14,'color','k','rotation',0,'fontweight','bold')
    colormap(map3);
end