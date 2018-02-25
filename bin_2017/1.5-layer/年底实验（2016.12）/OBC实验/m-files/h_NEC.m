%% x-t图  14N h_a
clear;clc
load map3;
rang = {'120E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E','250E','260E'};
for EB =200
    figure;
    load(['../Input/OBC_upper_h_',num2str(EB),'E.mat']);
    nx = (EB-100)*4+1;
    h1 = reshape(upper_h,[nx 360 10]);   % 14N
    h1_1=mean(reshape(mean(h1,3),[nx 30 12]),2);
    h1_2=reshape(h1_1,[nx 12]);
    h_a = zeros(nx,12);
    for i = 1:nx
        for j = 1:12
            h_a(i,j) = h1_2(i,j) - nanmean(h1_2(i,:));
        end
    end
    h_a_max = max(max(h_a));   % 126E-136E
    h_a_min  = min(min(h_a));   % 126E-136E
    h_a=[h_a';h_a'];
    %图锟斤拷锟斤拷锟斤拷
    [c,h] = contourf(h_a,floor(h_a_min):5:ceil(h_a_max));
    set(h,'ShowText','on','labelspacing',1000)
    %caxis([-25 25])
    hold on
    ylabel('Month');
    title({['The Propagation of Upper-layer depth Anomalies'];['Boundary : ',num2str(EB),'E']})
    if (nx>=641)
        xlim([101,641])
        ylim([1,24])
        set(gca,'XTick',[101 121:40:641]);
        set(gca,'XTickLabel',rang(1:end));
    else
        xlim([101,nx])
        ylim([1,24])
        set(gca,'XTick',[101 121:40:nx]);
        set(gca,'XTickLabel',rang(1:(EB-120)/10+1));
    end
    set(gca,'YTick',1:24);
    set(gca,'YTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec', ...
        'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    colorbar;
    set(gca, 'Clim', [-25 25]);
    colormap(map3);
    %saveas(gcf,['../Output/',num2str(EB),'E_h_a.jpg']);
end
%%  x-t图  13N - 15N  126E h_a
clear;clc
load map3;
rang = {'14N','15N','16N'};
for EB = 280
    figure;
    load(['../Input/OBC_H_',num2str(EB),'E.mat']);
    ny_1 = (14-10)*4+1;
    ny_2 = (16-10)*4+1;
    ny     = length(ny_1:ny_2);
    h1 = reshape(upper_H(121,ny_1:ny_2,:),[ny 360 10]);   % 130E
    h1_1=mean(reshape(mean(h1,3),[ny 30 12]),2);
    h1_2=reshape(h1_1,[ny 12]);
    h_a = zeros(ny,12);
    for i = 1:ny
        for j = 1:12
            h_a(i,j) = h1_2(i,j) - nanmean(h1_2(i,:));
        end
    end
    h_a_max = max(max(h_a));   % 126E-136E
    h_a_min = min(min(h_a));   % 126E-136E
    h_a=[h_a';h_a'];
    %图锟斤拷锟斤拷锟斤拷
    [c,h] = contourf(h_a);
    set(h,'ShowText','on','TextList',[-10:5:10])
    % contourf(h_a)
    hold on
    ylabel('Month');
    title({['The Propagation of Upper-layer depth Anomalies'];['Boundary : ',num2str(EB),'E']})
    xlim([1,9])
    ylim([1,24])
    set(gca,'XTick',[1:4:9]);
    set(gca,'XTickLabel',rang(1:end));
    set(gca,'YTick',1:24);
    set(gca,'YTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec', ...
        'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    colorbar;
    set(gca, 'Clim', [h_a_min h_a_max]);
    clabel(c,h,'manual','fontsize',14,'color','k','rotation',0,'fontweight','bold')
    colormap(map3);
    saveas(gcf,['../Output/',num2str(EB),'E_H_a.jpg']);
end
%% 看mean_H 的场
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
    %scrsz = get(0,'ScreenSize');
    %set(gcf,'Position',scrsz);
    %set(gcf, 'PaperPositionMode', 'auto')
    clabel(c,h,'manual','fontsize',14,'color','k','rotation',0,'fontweight','bold')
    %set(h,'ShowText','on','labelspacing',1000)
    colormap(map3);
    %saveas(gcf,['../Output/',num2str(EB),'E_h.jpg']);
end
%% 看case290E mean_H 场
clear;clc
load map3;
rang = {'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E','250E','260E'};
figure;
EB =290;
upper_H = importdata('../Input/OBC_H_290E.mat');
mean_H = mean(upper_H,3) + 350;
% 120E-EB,0N-35N mean_H 气候态场
lon = 120:1/4:290;
lat = 0:1/4:35;
[X,Y]=meshgrid(lon,lat);
m_proj('miller','lon',[120 290],'lat',[0 35]);
%m_proj('Equidistant Cylindrical','lon',[120 290],'lat',[0 35]);
m_coast('patch',[.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[3]);
m_grid('linestyle','none','box','fancy','tickdir','in','fontsize',14);
hold on
[c,h] = m_contourf(X,Y,mean_H');
clabel(c,h,'manual','fontsize',14,'color','k','rotation',0,'fontweight','bold')
%colormap(map3);
%saveas(gcf,['../Output/',num2str(EB),'E_h.jpg']);
%% 计算西太h场的南北h_a异常差
clear;clc
load map3;
i = 0;
for EB = 150:10:280
    i = i+1;
    load(['../Output/orlanski_H_NP_',num2str(EB),'E.mat']);
    nx = (EB-120)*4+1;
    mean_H = H_NP;
    %8N-18N,126E-136E计算南北h_a异常差
    h_a_max = max(mean(H_NP(25:65,21:61),1));
    h_a_min = min(mean(H_NP(25:65,21:61),1));
    distance(i) = h_a_max - h_a_min;
end
x=1:i;
plot(x,distance,'-bo','LineWidth',1.5)
xlim([1,i])
ylim([110,160])
hold on
ylabel('difference of h');
set(gca,'XTick',1:i);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W'});
%set(gca,'YTick',0:10:160)
%saveas(gcf,'../Output/orlanski h_a different.bmp')
%box off
%% 画 u&v 场, 并标注分叉点的位置
clear;clc
load map3;
figure;
upper_u = importdata('../Input/OBC_trans_290E_u.mat');
upper_v = importdata('../Input/OBC_trans_290E_v.mat');
upper_h = importdata('../Input/OBC_trans_290E_h.mat');
H = mean(upper_h,3) + 350;
U = mean(upper_u,3);
V = mean(upper_v,3);
% 120E-140E,6N-21N    u&v&H气候态场
lon = 120:1/4:140;
lat = 0:1/4:30;
[X,Y]=meshgrid(lon,lat);
%m_proj('miller','lon',[120 140],'lat',[4 21]);
m_proj('miller','lon',[120 140],'lat',[4,21]);
%m_proj('Equidistant Cylindrical','lon',[120 290],'lat',[0 35]);
m_coast('patch',[.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',3);
m_grid('linestyle','none','box','fancy','tickdir','in','fontsize',14);
hold on
Velocity = sqrt(U.^2+V.^2);
U(Velocity<=0.1)=nan; 
V(Velocity<=0.1)=nan; 
H(Velocity<=0.04)=nan;
scale = 2;
m_quiver(X(1:scale:end,1:scale:end),Y(1:scale:end,1:scale:end),U(1:scale:end,1:scale:end)',V(1:scale:end,1:scale:end)',3,'k')
[c,h] = m_contour(X(1:scale:end,1:scale:end),Y(1:scale:end,1:scale:end),H(1:scale:end,1:scale:end)','-k');
clabel(c,h,'manual','fontsize',14,'color','k','rotation',0,'fontweight','bold','linewidth',4)
hold on
m_line(124,14.5,'marker','o','markersize',8,'color','k');
%m_text(124,14.5,' M5','vertical','top');
%colormap(map3);
%saveas(gcf,['../Output/',num2str(EB),'E_h.jpg']);