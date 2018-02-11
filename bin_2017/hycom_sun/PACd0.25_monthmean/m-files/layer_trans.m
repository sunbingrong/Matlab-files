% 18N 源地黑潮的流量 Kuroshio
clear;clc;

data.lon = load('../Input/hycom.plon');
data.lat  = load('../Input/hycom.plat');

load map3.mat

y = 18; %18N
delta_x = 6.371e6*cos(y*pi/180)*(0.25*pi/180);

lon = data.lon(1,:);
lat  = flipud(data.lat(:,1));
m   =  length(lon);
n    =  length(lat);
a = find(lon >=122.25 & lon<=124.25);
b = find(lat >=17.75 & lat <=18.25);

for year = 2:5
    for month = 1:12
        v = load(['../Input/01-19v3d.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        v(abs(v)>=1.5)= nan;
        H = load(['../Input/01-19thknss3d.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        H(H == -999.9) = nan;
        H(H>=1000) = nan;
        %H(isnan(v)) = 0;
        %v(isnan(v))  = 0;
        vv = flipud(v)';
        HH = flipud(H)';
        
        a1 = HH(a,b);
        a2 = vv(a,b);
        H_trans =nanmean(a1,2);
        V_trans = nanmean(a2,2);
        trans(year,month) = 450/mean(H_trans)*V_trans'*H_trans*delta_x/10^6;
    end
    trans_min = min(trans(year,:));
    trans_max= max(trans(year,:));
    subplot(4,4,year);
    plot(trans(year,:),'LineWidth',3.5)
    xlim([1 12])
    ylim([floor(trans_min) ceil(trans_max)])
    set(gca,'XTick',1:12)
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    %set(gca,'YTick',floor(trans_min):ceil(trans_max))
    p1 = get(gca,'position');
    xlabel('Month');
    if mod(year,4) == 1
        ylabel('Sv')
        set(gca,'position',p1);
    else
        if mod(year,4) == 0
            p1(1) = p1(1) - 0.03*3;
            set(gca,'position',p1);
        else
            p1(1) = p1(1) - 0.03*(mod(year,4)-1);
            set(gca,'position',p1);
        end
    end
    p1(2) = p1(2) - 0.016*ceil(year/4-1);
    set(gca,'position',p1);
    title('Control Run KC Transport');
    %title('Seasonal Transport in Source Region of Kuroshio')
    set(gca,'fontsize',12)
    disp(['Processing : ',num2str(year)])
end
%% Mean Transport of KC
figure
trans_mean  = mean(trans(2:3,:),1);
trans_mean = smooth(trans_mean,3);
plot([1:12],trans_mean,'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Sv');
title('PACb0.25   KC  Transport')
set(gca,'fontsize',11)
%save('../Output/18N_Trans_Ctrl.mat','Trans_Ctrl');
save('../Output/18N_Trans_210E.mat','trans_mean');
%% 8N 棉兰老流的流量 Mindanao Current
clear;clc;
data.lon = load('../Input/hycom.plon');
data.lat  = load('../Input/hycom.plat');

load map3.mat

y = 8;  %8N
delta_x = 6.371e6*cos(y*pi/180)*(0.25*pi/180);

lon = data.lon(1,:);
lat  = flipud(data.lat(:,1));
m   =  length(lon);
n    =  length(lat);
a = find(lon >=127.25 & lon<=129);
b = find(lat >=7.75 & lat<=8.25);

for year = 2:5
    for month = 1:12
        v = load(['../Input/01-19v3d.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        v(abs(v)>=1.5)= nan;
        H = load(['../Input/01-19thknss3d.00',num2str(year+10),'_',num2str(month,'%.2d'),'.dat']);
        H(H == -999.9) = nan;
        H(H>=1000) = nan;
        %H(isnan(v)) = 0;
        %v(isnan(v))  = 0;
        vv = flipud(v)';
        HH = flipud(H)';
        
        a1 = HH(a,b);
        a2 = vv(a,b);
        H_trans =nanmean(a1,2);
        V_trans = nanmean(a2,2);
        H_trans(isnan(H_trans)) = 0;
        V_trans(isnan(V_trans))  = 0;
        trans(year,month) = -V_trans'*H_trans*delta_x/10^6;
        %trans(year,month) = -400/mean(H_trans)*V_trans'*H_trans*delta_x/10^6;
    end
    trans_min = min(trans(year,:));
    trans_max= max(trans(year,:));
    subplot(4,4,year);
    plot(trans(year,:),'LineWidth',3.5)
    xlim([1 12])
    ylim([floor(trans_min) ceil(trans_max)])
    set(gca,'XTick',1:12)
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    %set(gca,'YTick',floor(trans_min):ceil(trans_max))
    p1 = get(gca,'position');
    xlabel('Month');
    if mod(year,4) == 1
        ylabel('Sv')
        set(gca,'position',p1);
    else
        if mod(year,4) == 0
            p1(1) = p1(1) - 0.03*3;
            set(gca,'position',p1);
        else
            p1(1) = p1(1) - 0.03*(mod(year,4)-1);
            set(gca,'position',p1);
        end
    end
    p1(2) = p1(2) - 0.016*ceil(year/4-1);
    set(gca,'position',p1);
    title('Control Run KC Transport');
    %title('Seasonal Transport in Source Region of Kuroshio')
    set(gca,'fontsize',12)
    disp(['Processing :  year ',num2str(year)])
end
figure
trans_mean  = mean(trans(2:3,:),1);
trans_mean = smooth(trans_mean);
plot(trans_mean)
save('../Output/8N_transport.mat','trans_mean');
%% Mean Transport of MC
figure
trans_mean = importdata('../Output/8N_transport.mat');
%trans_mean  = mean([trans(2,:);trans(5,:);trans(10,:)],1);
%trans_mean = smooth(trans_mean);
plot([1:12],trans_mean,'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Sv');
title('PACb0.25  MC Transport')
set(gca,'fontsize',11)