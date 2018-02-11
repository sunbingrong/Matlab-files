clc;clear;
load('../Output/nbl_nec_jf.mat')
c = mean(nbl_new_jf,1);
plot([1:12],c,'-bo','LineWidth',1.5)
set(gca,'XTick',1:12);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');
ylabel('Latitude(°„N)');
saveas(gcf,'../Output/ROMS_bifur.jpg');
% clf;
% plot(mean(nbl_soda_jf,1))
% xlim([1 12])
% saveas(gcf,'../Output/SODA_bifur.jpg');