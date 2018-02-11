%% »­basic_hµÄÍ¼
clear
load map3;
load('basic_uvh.mat');
h1=h(161:641,135,:);
h1=reshape(h1,[481,360]);
%h2=reshape(h1,[481,1,30,12]);
%h2=reshape(h2,[481,30,12]);
%h2_mean=sum(h2,2)/30;
h2_mean = h1;
% for  j=1:12
%      h_a(:,j)=h1(:,30*(j-1)+1)-h2_mean(:,j);
% end
[m,n] = size(h2_mean);
h_a = zeros(m,n);
for i = 1:m
    for  j=1:n
        h_a(i,j)=h2_mean(i,j)-mean(h2_mean(i,:));
    end
end
    h_a=[h_a';h_a'];
    %Í¼ÐÎÉèÖÃ
    figure
    contourf(h_a)
    xlim([1,481])
    ylim([1,n*2])
    hold on
    ylabel('Month');
    title('The Propagation of Upper-layer depth Anomalies')
    set(gca,'XTick',1:40:481);
    set(gca,'XTickLabel',{'140E','150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W','100W'});
    set(gca,'YTick',1:30:n*2);
    set(gca,'YTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec', ...
        'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    colorbar;
    colormap(map3);
    saveas(gcf,'basic_h.jpg');
%% »­250E_hµÄÍ¼
% »­Í¼ÇøÓò£º125E - 115W
clear;clc
load map3;
rang = {'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E,','250E','260E'};
for EB = 230
    figure;
    load([num2str(EB),'E_uvh.mat']);
    nx = (EB-100)*4+1;
    h1 = reshape(h(:,137,end-71:end),[nx 72]);   % 14N
    for i = 1:nx
    for j = 1:12
        h2(i,j)=mean(h1(i,6*(j-1)+1:6*j));
    end
    end
    h_a = zeros(nx,12);
    for i = 1:nx
        for j = 1:12
            h_a(i,j) = h2(i,j) - mean(h2(i,:));
        end
    end
    h_a=[h_a';h_a'];
    %Í¼ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
    contourf(h_a)
    hold on
    ylabel('Month');
    title('The Propagation of Upper-layer depth Anomalies')
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
    saveas(gcf,[num2str(EB),'E_h.jpg']);
end