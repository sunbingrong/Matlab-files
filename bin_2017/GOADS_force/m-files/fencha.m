%% GODAS force bifurcation 
clear;clc
fid = importdata('../Output/basicwind150E_bifur_PHI_GOADS.dat');
bifur = fid(3601:end,3);
a=reshape(bifur,[30,12,10]);
b=mean(a,3);
c=mean(b,1);
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°N)');
title('180E    Force: Mean     BC: Control Run ')
% scrsz = get(0,'ScreenSize');
% set(gcf,'Position',scrsz);
% set(gcf, 'PaperPositionMode', 'auto')
%saveas(gcf,'../Output/baisicwind150E_bifur_GOADS.tif');
%% 动能和势能
clear;
fid = load('../Output/dissi150E_stdout.dat');
kinetic = fid(:,4);
potential = fid(:,5);