% x-tͼ
clear;clc
load map3;
rang = {'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E,','250E','260E'};
for EB = 140:10:280
    figure;
    load(['../Output/meanwind_h_',num2str(EB),'E.mat']);
    nx = (EB-100)*4+1;
    h1 = reshape(H_NP,[nx 360 10]);   % 14N
    h1_1=mean(reshape(mean(h1,3),[nx 30 12]),2);
    h1_2=reshape(h1_1,[nx 12]);
    h_a = zeros(nx,12);
    for i = 1:nx
        for j = 1:12
            h_a(i,j) = h1_2(i,j) - nanmean(h1_2(i,:));
        end
    end
    h_a=[h_a';h_a'];
    %ͼ������
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
    saveas(gcf,['../Output/meanwind_',num2str(EB),'E_h.jpg']);
end