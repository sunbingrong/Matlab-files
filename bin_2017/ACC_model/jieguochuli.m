%% 处理能量
load stdout3600.mat
x=1:3600;
y1=stdout3600(:,4);
subplot(1,2,1)
plot(x,y1)
hold on
y2=stdout3600(:,5);
subplot(1,2,2)
plot(x,y2)
hold on
%% 处理流速场动态图
 x=1:6:960;y=1:2:72;
 [X,Y]=meshgrid(x,y);
u11=zeros(160,36);
v11=zeros(160,36);
U1=zeros(160,36,360);
V1=zeros(160,36,360);
for l=1:360
    u1=u(:,:,l);
    v1=v(:,:,l);
    for i=1:160
        for j=1:36
            u11(i,j)=u1(1+4*(i-1),1+2*(j-1));
            v11(i,j)=v1(1+4*(i-1),1+2*(j-1));
        end
    end
    U1(:,:,l)=u11;
    V1(:,:,l)=v11;
end
quiver(X',Y',U1(:,:,1),V1(:,:,1))
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';
loops=120;
F(loops) = struct('cdata',[],'colormap',[]);
for k = 1:loops
    quiver(X',Y',U1(:,:,k),V1(:,:,k));
    %drawnow;
    if k==loops
       fprintf(1,'ok');
    end
    F(k)=getframe(gcf);  
    im=frame2im(F(k));%制作gif文件，图像必须是index索引图像  
    [I,map]=rgb2ind(im,256);          
    if k==1
        imwrite(I,map,'1.gif','gif', 'Loopcount',inf,'DelayTime',0.5);%第一次必须创建！
    else
        imwrite(I,map,'1.gif','gif','WriteMode','append','DelayTime',0.5);
    end
end
%% ACC流场图 
x=1:12:960;y=1:4:72;
[X,Y]=meshgrid(x,y);
u11=zeros(80,18);
v11=zeros(80,18);
    for i=1:80
        for j=1:18
            u11(i,j)=u(1+12*(i-1),1+4*(j-1));
            v11(i,j)=v(1+12*(i-1),1+4*(j-1));
        end
    end
quiver(X',Y',u11,v11);
axis tight manual
%% 上层厚度图
clear
load vel.mat
x=0.375:3.75:280;y=-65:0.375:-38.375;
[X,Y]=meshgrid(x,y);
m_proj('miller','long',[0.5 360],'lat',[-70 -30]);
m_coast('patch',[1 .85 .7]);
m_elev('contourf',[500:500:6000]);
m_grid('box','fancy','tickdir','in');
hold on
[cs,h]=m_contour(X',Y',h(1:10:746,:));
clabel(cs,h,'fontsize',8);
xlabel('Simulated something else');


