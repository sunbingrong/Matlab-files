%% ��basic_h��ͼ
    % ��ͼ����120E - 270E
    clear;clc
    load map3.mat;
    load(['../Output/H_290E.mat']);
    h1 = H_NP(:,17,:);   % 14N
    h1_1=reshape(h1,[681,12,36]);
    h1_2=sum(h1_1,3)/36;
    [m,~] = size(h1_2);
    h_a = zeros(m,12);
    for j = 1:12
        h_a(:,j) = h1_2(:,j) - nanmean(h1_2(:,j));
    end
    h_a=[h_a(1:561,:)';h_a(1:561,:)'];
    %ͼ������
    a = axes;
    contourf(h_a)
    h_a_Max = max(h_a(~isnan(h_a)));
    h_a_Min = min(h_a(~isnan(h_a)));
    xlim([21,561])
    ylim([1,24])
    hold on
    ylabel('Month');
    title('The Propagation of Upper-layer depth Anomalies')
    set(gca,'XTick',[21 41 81 121 161 201 241 281 321 361 401 441 481 521 561]);
    set(gca,'XTickLabel',{'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E,','250E','260E'});
    set(gca,'YTick',1:24);
    set(gca,'YTickLabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec', ...
        'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
    colorbar;
    set(a, 'CLim', [h_a_Min h_a_Max]);
    colormap(map3);
    saveas(gcf,'../Output/basic_h_a.jpg');
