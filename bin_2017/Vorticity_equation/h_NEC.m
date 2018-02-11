%%
clear;clc
load map3;
rang = {'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E,','250E','260E'};
for EB = 290
    figure;
    load(['Output/H_',num2str(EB),'E.mat']);
    h1 = H_NP(40,:,121:132);   % 130E
    h1_1=reshape(h1,[41,12]);
    h1_2=h1_1;
    %h1_2=nanmean(h1_1,3);
    [m,~] = size(h1_2);
    h_a = zeros(m,12);
    for i = 1:m
        for j = 1:12
            h_a(i,j) = h1_2(i,j) - mean(h1_2(i,:));
        end
    end
    n = zeros(1,12);
    for month = 1:12
        for i = 1:40
            if (h_a(i,month)*h_a(i+1,month)<0)
                n(month) = i;
                break;
            end
        end
    end
    x  = 1:12;
    y = (n-1)./4+10;
    % xi = 1:12;
    % yi=interp1(y,xi,'spline');
    % plot(x,y,'o',xi,yi);
    values = spcrv([[x(1) x x(end)];[y(1) y y(end)]],3);
    t = values(1,:);
    latitude = values(2,:);
    plot(x,y, '-bo');
    %plot(t,latitude, 'b');
    set(gca,'XTick',1:12);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    ylabel('Latitude(¡ãN)');
end