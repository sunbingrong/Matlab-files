%% ÿ���µ�curl��ͼ
clear;clc
load('../Input/curl_quar_290.mat')
month = {'1��';'2��';'3��';'4��';'5��';'6��';'7��';'8��';'9��';'10��';'11��';'12��'};
for EB = 140
    nx = 4*(EB-100)+1;
for i = 1:12
    figure
    [c,h]=contourf(curl(1:nx,:,i)');
    set(h,'ShowText','on')
    %set(h,'ShowText','on','labelspacing',10)
    %set(h,'ShowText','on','TextList',0)
    %saveas(gcf,['curl_',char(month(i)),'.bmp'])
end
end
%% ��ƽ��curl��ͼ
clear;clc
load('../Input/curl_quar_290.mat')
month = {'1��';'2��';'3��';'4��';'5��';'6��';'7��';'8��';'9��';'10��';'11��';'12��'};
for EB = 280
    nx = 4*(EB-100)+1;
    curl_mean = mean(curl(1:nx,:,:),3);
    figure
    [c,h]=contourf(curl_mean');
    set(h,'ShowText','on')
    %set(h,'ShowText','on','labelspacing',10)
    %set(h,'ShowText','on','TextList',0)
    %saveas(gcf,['curl_',char(month(i)),'.bmp'])
end