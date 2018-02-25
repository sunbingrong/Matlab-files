%% x-t图
clear;clc
load map3;
rang = {'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E','250E','260E'};
for EB = 290
    figure;
    load(['../Output/H_',num2str(EB),'E_anomaly.mat']);
    nx = (EB-100)*4+1;
    h1 = reshape(H_NP(:,17,:),[nx 432]);   % 14N
    h1_1=reshape(h1,[nx,12,36]);
    %h1_2=sum(h1_1,3)/36;
    h1_2=mean(h1_1,3);
    [m,~] = size(h1_2);
    h_a = zeros(m,12);
    for i = 1:m
        for j = 1:12
            h_a(i,j) = h1_2(i,j) - nanmean(h1_2(i,:));
        end
    end
    h_a=[h_a';h_a'];
    %图锟斤拷锟斤拷锟斤拷
    contourf(h_a)
    hold on
    ylabel('Month');
    title('The Propagation of Upper-layer thickness Anomalies')
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
    %set(a, 'CLim', [h_a_Min h_a_Max]);
    colormap(map3);
    saveas(gcf,['../Output/',num2str(EB),'E_h_anomaly.jpg']);
end
%% 判断分叉点的位置(old)
clear;clc
for EB = 290
    figure;
    load(['../Output/H_',num2str(EB),'E_ECMWF.mat']);
    h1 = H_NP(121,:,193:432);   % 130E
    h1_1=reshape(h1,[101,12,20]);
    h1_2=mean(h1_1,3);
    [m,~] = size(h1_2);
    h_a = zeros(m,12);
    for i = 1:m
        for j = 1:12
            h_a(i,j) = h1_2(i,j) - nanmean(h1_2(i,:));
        end
    end
    n = zeros(1,12);
    for month = 1:12
        for i = 10:40
            if (h_a(i,month)*h_a(i+1,month)<0)
                n(month) = i;
                break;
            end
        end
    end
    x  = 1:12;
    y  = (n-1)./4+10;
    xi = 1:12;
    %   yi=interp1(y,xi,'spline');
    %plot(x(1:12),y(1:12),'b');
    yi = band(y,11,13);
    plot(xi(1:12),yi(1:12), 'b');
    %   values = spcrv([[x(1) x x(end)];[y(1) y y(end)]],3);
    %   t = values(1,:);
    %    latitude = values(2,:);
    %    plot(t,latitude, 'b');
    %    set(gca,'XTick',1:24);
    %   set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    ylabel('Latitude(°N)');
end
%% 风应力异常吹出来的数据判断分叉点的位置
clear;clc
for EB = 290
    figure;
    load(['../Output/H_',num2str(EB),'E_anomaly.mat']);
    h1 = H_NP(101:121,:,1:12);   % 125E-127E
    h1_1=reshape(h1,[21,101,12]);
    h1_2=nanmean(h1_1,1);
    h1_3=reshape(h1_2,[101 12]);
    [m,~] = size(h1_3);
    h_a = zeros(m,12);
    %     for i = 1:m
    %         for j = 1:12
    %             h_a(i,j) = h1_2(i,j) - nanmean(h1_2(i,:));
    %         end
    %     end
    n = zeros(1,12);
    for month = 1:12
        for i = 10:40
            if (h1_3(i,month)*h1_3(i+1,month)<0)
                n(month) = i;
                break;
            end
        end
    end
    x  = 1:12;
    y  = (n-1)./4+10;
    xi = 1:12;
    %yy1 = smooth(y,'moving');
    %yy2 = smooth(y,'rloess');
    %yi=interp1(y,xi,'spline');
    %plot(x(1:12),y(1:12),'-bo');
    yy1 = low_pass(y,11);
    plot(1:24,[yy1(1:12)' yy1(1:12)'], '-bo');
    %values = spcrv([[x(1) x x(end)];[y(1) y y(end)]],3);
    %t = values(1,:);
    %latitude = values(2,:);
    %plot(t,latitude, 'b');
    set(gca,'XTick',1:24);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    ylabel('Latitude(°N)');
end
%% 判断分叉点的位置(New)
clear;clc
k = 0;
for EB = 150:10:290
    k = k + 1;
    load(['../Output/H_',num2str(EB),'E_ECMWF.mat']);
    h1 = H_NP(101:121,:,1:12);   % 125E-127E
    h1_1=reshape(h1,[21,101,12]);
    h1_2=nanmean(h1_1,1);
    h1_3=reshape(h1_2,[101 12]);
    [m,~] = size(h1_3);
    h_a = zeros(m,12);
    %     for i = 1:m
    %         for j = 1:12
    %             h_a(i,j) = h1_2(i,j) - nanmean(h1_2(i,:));
    %         end
    %     end
    n = zeros(1,12);
    for month = 1:12
        for i = 10:40
            if (h1_3(i,month)*h1_3(i+1,month)<0)
                n(month) = i;
                break;
            end
        end
    end
    x  = 1:12;
    y  = (n-1)./4+10;
    xi = 1:12;
    %yy1 = smooth(y,'moving');
    %yy2 = smooth(y,'rloess');
    %yi=interp1(y,xi,'spline');
    %plot(x(1:12),y(1:12),'-bo');
    yy1 = low_pass(y,11);
    subplot(4,4,k)
    %plot(1:24,[yy1(1:12)' yy1(1:12)'], '-bo','linewidth',1.5);
    plot(1:24,[yy1(1:12)' yy1(1:12)'], '-bo','Linewidth',2,'MarkerFaceColor','b','MarkerSize',4);
    p1 = get(gca,'position');
    set(gca,'XTick',1:24);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    set(gca,'ylim',[14 15.5])
    %values = spcrv([[x(1) x x(end)];[y(1) y y(end)]],3);
    %t = values(1,:);
    %latitude = values(2,:);
    %plot(t,latitude, 'b');
    if mod(k,4) == 1
        ylabel('Latitude(°N)');
        set(gca,'position',p1);
    else
        if mod(k,4) == 0
            p1(1) = p1(1) - 0.04*3;
            set(gca,'position',p1);
            set(gca,'YTickLabel','')
        else
            p1(1) = p1(1) - 0.04*(mod(k,4)-1);
            set(gca,'position',p1);
            set(gca,'YTickLabel','')
        end
    end
    p1(2) = p1(2) - 0.01*ceil(k/4-1);
    set(gca,'position',p1);
    if EB == 290
        title('Control Run');
    else
        title(['EB:  ', num2str(EB),'E'])
    end
    EB
end
%saveas(gca,'../Output/Rossby_bifur.jpg')