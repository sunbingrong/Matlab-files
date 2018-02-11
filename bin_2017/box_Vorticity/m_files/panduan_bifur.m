clear;clc
load map3;
rang = {'125E','130E','140E','150E','160E','170E','180E','190E','200E','210E','220E','230E','240E,','250E','260E'};
for EB = 290
    figure;
    load(['../Output/H_',num2str(EB),'E.mat']);
    h1 = H_NP(121,1:41,:);   % 130E 10 N - 20  N
    h1_1=reshape(h1,[41,12,36]);
    h1_2=mean(h1_1,3);
    %h1_2=nanmean(h1_1,3);
    [m,~] = size(h1_2);
    n = zeros(1,12);
    for month = 1:12
        for i = 1:40
            if (h1_2(i,month)*h1_2(i+1,month)<0)
                n(month) = i;
                break;
            end
        end
    end
    x  = 1:12;
    y  = (n-1)./4+10;
    %xi = 1:12;
    %yi=interp1(y,xi,'spline');
    %plot(x,y,'o',xi,yi);
    values = spcrv([[x(1) x x(end)];[y(1) y y(end)]],3);
    t = values(1,:);
    latitude = values(2,:);
    plot(t,latitude, 'b');
    set(gca,'XTick',1:24);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    ylabel('Latitude(¡ãN)');
end