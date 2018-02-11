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
filename = 'xlx.gif';        %�ļ���Ϊxlx.gif
for i = 1:length(th)
    set(h1,'XData',xi+th(i))
    set(h2,'XData',th(i)-sin(th(i)),'YData',1-cos(th(i)))
    set(h3,'XData',[th(i),th(i)-sin(th(i))],...
        'YData',[1,1-cos(th(i))])
    plot(th(i)-sin(th(i)),1-cos(th(i)),'r.')
    f = getframe(gca);                               %��õ�ǰ���������
    imind = frame2im(f);                          %ת��ΪͼƬ��ʽ
    [imind,cm] = rgb2ind(imind,256);        %��RGB��ɫͼת��Ϊ����ͼ��
    if i == 1                                             %����ǵ�һ֡���½�GIF�ļ�
        imwrite(imind,cm,filename,'gif','Loopcount',inf,'DelayTime',0.1)
    else                                                   %������ǵ�һ֡����չGIF�ļ�
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1)
    end
    pause(0.1)
end