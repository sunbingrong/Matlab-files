%% 动态绘制椭圆
 clf;axis([-2,2,-2,2]);
 axis equal;
 pause(1);
 h=line(NaN,NaN,'marker','o','linesty','-');
 t=6*pi*(0:0.02:1);
 for n=1:length(t)
     set(h,'xdata',2*cos(t(1:n)),'ydata',sin(t(1:n)));
     pause(0.1);%暂停0.05秒
 end
 %% 貌似函数comet,comet3可以实现质点动画
 %comet(xdata,ydata,p)  p为彗星尾巴长度，可为常数
 %平抛运动
 vx=40;
 t=linspace(0,10,1000);
 x=vx*t;
 y=-9.8*t.^2/2;
 comet(x,y)
 %% hh
figure
Z = peaks;
surf(Z)
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';

loops = 40;
F(loops) = struct('cdata',[],'colormap',[]);
for j = 1:loops
    X = sin(j*pi/10)*Z;
    surf(X,Z)
    drawnow
    F(j) = getframe;
end
movie(F,4)