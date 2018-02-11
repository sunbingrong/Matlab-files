%-------------------------------- m_quiver -------------------------------%
% �ص�1��
% m_quiver(x(1:d:end,1:d:end),y(1:d:end,1:d:end),ustr_1_2(1:d:end,1:d:end)'./dd,vstr_2_1(1:d:end,1:d:end)'./dd,0);
% m_quiver(30,-80,500./dd.*cosd(-80),0,0)
% Ϊ��ʹ�÷糡�ͱ�ߵĴ�Сһ�£���m_quiver�����һ��ֵ����Ϊ��0��������scale=0
% quiver(x,y,u,v,scale);
% 
% �ص�2��
%  d = 3;dd =10;
%  m_quiver(x(1:d:end,1:d:end),y(1:d:end,1:d:end),ustr_1_2(1:d:end,1:d:end)'./dd,vstr_2_1(1:d:end,1:d:end)'./dd,0);
% 
% ͨ��d��������ͷ��࣬dd��������ͷ���ȣ���ֵ��С��
% 
% �ص�3��
%  ustr_1_2=ustr_1_1.*cosd(y');
%  h=m_quiver(30,-80,500./dd.*cosd(-80),0,0);  ��һ��0ָ������б�Ƕȣ��ڶ���0ָ����scale,�Ŵ���
% m_map ���õ���������ϵ������Ҫ�����е�γ�����������cosd��γ�ȣ�  ע�⣺��cosd��γ�ȣ� cos�����ȣ�
% ����γ����ÿ��γ��������Ӧ��γ��
% ��ustr_1_2=ustr_1_1.*cosd(y');���棬����cosd��y'�� Ҫ��ϸ��飬����һ��һ����Ӧ��ȥ��
%-------------------------------------------------------------------------%
% ʾ������
clear all;close all;clc
 %����
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
 