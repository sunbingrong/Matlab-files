load jingdu.mat
jd = jingdu(1,:);
ljs = jingdu(2,:);
zds = jingdu(3,:);
ljds = ljs./zds;
[b,stats]=robustfit(ljds,jd);
b
xx = linspace(min(ljds), max(ljds),100);
yy = polyval(b(end:-1:1),xx);
plot(ljds,jd, 'bo', xx,yy,'r-')
xlabel('连接度数'); ylabel('定位精度');
legend('数据点','回归直线','location','best')