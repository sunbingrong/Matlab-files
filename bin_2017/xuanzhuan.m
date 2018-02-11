t = linspace(0,2*pi);
xi = cos(t);
yi = 1 + sin(t);
hold on
h1 = plot(xi,yi);
h2 = plot(0,0,'ro');
h3 = plot([0,0],[0,1],'k-');
plot(0,0,'r.');
axis equal
axis([-1.1,7.5,0,2.1])
th = t;
filename = 'xlx.gif';        %文件名为xlx.gif
for i = 1:length(th)
    set(h1,'XData',xi+th(i))
    set(h2,'XData',th(i)-sin(th(i)),'YData',1-cos(th(i)))
    set(h3,'XData',[th(i),th(i)-sin(th(i))],...
        'YData',[1,1-cos(th(i))])
    plot(th(i)-sin(th(i)),1-cos(th(i)),'r.')
    f = getframe(gca);                               %获得当前坐标轴对象
    imind = frame2im(f);                          %转换为图片格式
    [imind,cm] = rgb2ind(imind,256);        %将RGB彩色图转换为索引图像
    if i == 1                                             %如果是第一帧，新建GIF文件
        imwrite(imind,cm,filename,'gif','Loopcount',inf,'DelayTime',0.1)
    else                                                   %如果不是第一帧，扩展GIF文件
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1)
    end
    pause(0.1)
end