%% 处理能量
Energy_IP=stdout(:,4);
[s,t]=size(Energy_IP);
x=1:s;y=Energy_IP';
plot(x,y)
%% 处理流速,全部流域
x=30:1:290;y=-45:1:30;
[X,Y]=meshgrid(x,y);
 j=1;
 for i=1:90:360
     if (j<=4)
        n=1;
        U(:,:,j)=u(:,:,i);
        if (n<=89)
            i=i+1;
            U(:,:,j)=U(:,:,j)+u(:,:,i);
            n=n+1;
        end
        j=j+1;
     end
 end
for i=1:90:360
   if (j<=4)
        n=1;
        V(:,:,j)=v(:,:,i);
        if (n<=89)
            i=i+1;
            V(:,:,j)=v(:,:,j)+v(:,:,i);
            n=n+1;
        end
        j=j+1;
   end
end
u11=zeros(261,76);
v11=zeros(261,76);
U1=zeros(261,76,360);
V1=zeros(261,76,360);
for l=1:360
    u1=u(:,:,l);
    v1=v(:,:,l);
    for i=1:261
        for j=1:76
            u11(i,j)=u1(1+2*(i-1),1+2*(j-1));
            v11(i,j)=v1(1+2*(i-1),1+2*(j-1));
        end
    end
    U1(:,:,l)=u11;
    V1(:,:,l)=v11;
end
quiver(X',Y',U1(:,:,1),V1(:,:,1))
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';
loops=200;
F(loops) = struct('cdata',[],'colormap',[]);
for k = 1:loops
    quiver(X',Y',U1(:,:,k),V1(:,:,k))
    drawnow;
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
%% 西澳大利亚寒流
x=30:1:130;y=-45:1:-15;
[X,Y]=meshgrid(x,y);
 j=1;
 for i=1:90:360
     if (j<=4)
        n=1;
        U(:,:,j)=u(:,:,i);
        if (n<=89)
            i=i+1;
            U(:,:,j)=U(:,:,j)+u(:,:,i);
            n=n+1;
        end
        j=j+1;
     end
 end
for i=1:90:360
   if (j<=4)
        n=1;
        V(:,:,j)=v(:,:,i);
        if (n<=89)
            i=i+1;
            V(:,:,j)=v(:,:,j)+v(:,:,i);
            n=n+1;
        end
        j=j+1;
   end
end
u11=zeros(101,31);
v11=zeros(101,31);
U1=zeros(101,31,360);
V1=zeros(101,31,360);
for l=1:360
    u1=u(:,:,l);
    v1=v(:,:,l);
    for i=1:101
        for j=1:31
            u11(i,j)=u1(1+2*(i-1),1+2*(j-1));
            v11(i,j)=v1(1+2*(i-1),1+2*(j-1));
        end
    end
    U1(:,:,l)=u11;
    V1(:,:,l)=v11;
end
quiver(X',Y',U1(:,:,1),V1(:,:,1))
axis tight manual
ax = gca;
ax.NextPlot = 'replaceChildren';
[lon,lat]=meshgrid([30:130],[-45:-15]);
m_proj('miller','long',[30 130],'lat',[-45 -15]);
m_coast('patch',[.9 .9 .9],'edgecolor','none');
m_grid('tickdir','out','yaxislocation','right',...
       'xaxislocation','bottom','xlabeldir','end','ticklen',.02);
hold on;
m_quiver(X',Y',U1(:,:,k),V1(:,:,k))
%% 秘鲁寒流