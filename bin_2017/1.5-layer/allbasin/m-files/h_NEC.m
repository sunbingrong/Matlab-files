%% x-t图
clear;clc
load map3;
rang = {'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E','250E','260E'};
for EB = 180
    figure;
    load(['../Output/allbasin_h_',num2str(EB),'E.mat']);
    nx = (EB-100)*4+1;
    h1 = reshape(H_NP(1:nx,:),[nx 360 10]);   % 14N
    h1_1=mean(reshape(mean(h1,3),[nx 30 12]),2);
    h1_2=reshape(h1_1,[nx 12]);
    h_a = zeros(nx,12);
    for i = 1:nx
        for j = 1:12
            h_a(i,j) = h1_2(i,j) - nanmean(h1_2(i,:));
        end
    end
    h_a=[h_a';h_a'];
    %图锟斤拷锟斤拷锟斤拷
    [c,h] = contourf(h_a);
    set(h,'ShowText','on','labelspacing',1000)
    %set(h,'ShowText','on','TextList',0)
    %contourf(h_a)
    hold on
    ylabel(['Month']);
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
    %     xlim([101,641])
    %     ylim([1,24])
    %     set(gca,'XTick',[101 121:40:641]);
    %     set(gca,'XTickLabel',rang(1:end));
    set(gca,'YTick',1:24);
    set(gca,'YTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec', ...
        'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    colorbar;
    %set(a, 'CLim', [h_a_Min h_a_Max]);
    colormap(map3);
    %saveas(gcf,['../Output/allbasin_',num2str(EB),'E_h.jpg']);
end
%% 看mean_H 的场
clear;clc
load map3;
rang = {'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E','250E','260E'};
for EB = 180
    figure;
    load(['../Output/allbasin_H_NP_',num2str(EB),'E.mat']);
    nx = (EB-120)*4+1;
    mean_H = H_NP + 350;
    % 126E-136E,10N-18N 找到分叉点对于的h_a_mean的大小
    h_notice = mean(H_NP(25:65,29:61),1);
    h_a_mean = mean(h_notice);
    lon = 120:1/4:EB;
    lat = 3:1/4:21;
    [X,Y]=meshgrid(lon,lat);
    m_proj('miller','lon',[120 EB],'lat',[3 21]);
    m_grid('linestyle','none','fontsize',20);
    m_coast('patch',[0.9 .9 .9],'edgecolor',[0.1 0.1 0.1],'linewidth',[3]);
    hold on
    [c,h] = m_contourf(X,Y,mean_H');
    %     scrsz = get(0,'ScreenSize');
    %     set(gcf,'Position',scrsz);
    %     set(gcf, 'PaperPositionMode', 'auto')
    clabel(c,h,'manual','fontsize',14,'color','k','rotation',0,'fontweight','bold')
    %set(h,'ShowText','on','labelspacing',1000)
    colormap(map3);
    %saveas(gcf,['../Output/',num2str(EB),'E_h.jpg']);
end
%% 计算西太h场的南北h_a异常差
clear;clc
load map3;
i = 0;
for EB = 150:10:280
    i = i+1;
    load(['../Output/allbasin_H_NP_',num2str(EB),'E.mat']);
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
ylim([100,160])
hold on
ylabel('difference of h');
set(gca,'XTick',1:i);
set(gca,'XTickLabel',{'150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W','90W','80W'});
%set(gca,'YTick',130:5:160);
%set(gca,'YTickLabel',1:10:150)
%saveas(gcf,'../Output/allbasin h_a different.bmp')
%box off