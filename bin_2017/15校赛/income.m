%% 门票收入
x=1:4;
yML=[0.98 1.22 1.273 1.293];
p1=polyfit(x,yML,1);
x1=1:0.1:4;
y1=polyval(p1,x1);
plot(x,yML,x1,y1)
%% 转播收入
x=1:4;
yHM=[0.98 1.992 1.883 2.042];
p2=polyfit(x,yHM,1);
x1=1:0.1:4;
y1=polyval(p2,x1);
plot(x,yHM,x1,y1)
%% 商业收入
x=1:4;
yBL=[1.457 1.992 2.547 3.277];
p3=polyfit(x,yBL,1);
x1=1:0.1:4;
y1=polyval(p3,x1);
plot(x,yBL,x1,y1)