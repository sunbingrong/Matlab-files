%clear
for i=250
     str1=num2str(i);
     str2='E_uvh.mat';
     str3=[str1,str2];
     load(str3)
 [s,t,k]=size(u);
 x=1:20:s;
 y=1:5:t;
 [X,Y]=meshgrid(x,y);
 u(end,end,720)=0.5;
 quiver(X,Y,u(1:20:end,1:5:end,720)',v(1:20:end,1:5:end,720)')
 text(x(end),y(end-1),'0.5m/s')
 hold on
 contour(basic_topo')
 %saveas(gca,['spd_',num2str(i),'E.pdf'])
end