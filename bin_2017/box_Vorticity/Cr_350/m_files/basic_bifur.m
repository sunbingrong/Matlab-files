% Baroclinic Rossby Wave Model Simulation
% Control Run Bifurcation (New)
clear;clc
EB = 290;
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
plot(1:24,[yy1(1:12)' yy1(1:12)'], '-bo','Linewidth',3,'MarkerFaceColor','b','MarkerSize',8);
p1 = get(gca,'position');
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
set(gca,'FontSize',12)
xlabel('Month','FontSize',12);
ylabel('Latitude(¡ãN)','FontSize',12);
set(gca,'position',p1);
title('Rossby Wave Model','FontSize',12);
%saveas(gca,'../Output/Rossby_bifur.jpg')