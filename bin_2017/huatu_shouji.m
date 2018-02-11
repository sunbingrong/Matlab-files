%-------------------------------- m_quiver -------------------------------%
% 重点1：
% m_quiver(x(1:d:end,1:d:end),y(1:d:end,1:d:end),ustr_1_2(1:d:end,1:d:end)'./dd,vstr_2_1(1:d:end,1:d:end)'./dd,0);
% m_quiver(30,-80,500./dd.*cosd(-80),0,0)
% 为了使得风场和标尺的大小一致，在m_quiver中最后一个值设置为“0”，即令scale=0
% quiver(x,y,u,v,scale);
% 
% 重点2：
%  d = 3;dd =10;
%  m_quiver(x(1:d:end,1:d:end),y(1:d:end,1:d:end),ustr_1_2(1:d:end,1:d:end)'./dd,vstr_2_1(1:d:end,1:d:end)'./dd,0);
% 
% 通过d来调整箭头间距，dd来调整箭头长度（数值大小）
% 
% 重点3：
%  ustr_1_2=ustr_1_1.*cosd(y');
%  h=m_quiver(30,-80,500./dd.*cosd(-80),0,0);  第一个0指的是倾斜角度，第二个0指的是scale,放大倍数
% m_map 中用的是球坐标系，所以要在所有的纬向量上面乘以cosd（纬度）  注意：是cosd（纬度） cos（弧度）
% 其中纬度是每个纬向量所对应的纬度
% 在ustr_1_2=ustr_1_1.*cosd(y');里面，乘以cosd（y'） 要仔细检查，可以一步一步对应着去找
%-------------------------------------------------------------------------%
% 示例程序
clear all;close all;clc
 %地形
 m_proj('miller','lat',[-90,90],'lon',[0,360]);
 m_coast('patch',[.6 .6 .6],'edgecolor','none');
 m_grid('box','fancy','linestyle','none');
 hold on
[X,Y]=meshgrid(1:360,1:180);
 d = 3;dd =10;
 u = rand(360,180);
 v = zeros(360,180);
 m_quiver(X,Y,u',v',0);
 hold on
 h=m_quiver(30,-80,500./dd.*cosd(-80),0,0); %%cosd cos(degree)
 set(h,'color','r','linewidth',1);
 hold on
 m_text(30,-75,'50m^2/s^2','fontsize',12);
 %------------------------------------------------------------------------%
 