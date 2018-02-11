%% 每个月的curl视图
clear;clc
load('../Input/curl_quar_290.mat')
month = {'1月';'2月';'3月';'4月';'5月';'6月';'7月';'8月';'9月';'10月';'11月';'12月'};
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
%% 年平均curl视图
clear;clc
load('../Input/curl_quar_290.mat')
month = {'1月';'2月';'3月';'4月';'5月';'6月';'7月';'8月';'9月';'10月';'11月';'12月'};
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