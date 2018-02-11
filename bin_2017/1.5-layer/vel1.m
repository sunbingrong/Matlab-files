clc
clear
dirs=dir('rst07200.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)' ;   
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;
%filename=textread('E:\papper\south_china_sea\seasonal_energy\outcome1\avedata\name.txt','%11c');
nx=761;
ny=221;
n=length(filenames);
u=zeros(nx,ny);v=zeros(nx,ny);
h=zeros(nx,ny);
i=1;
for t=n
    fid=fopen(strcat(char(filenames(t))));
    fid1=fread(fid,(nx*ny*3),'real*4');
    u1=fid1(1:nx*ny,1);
    u(:,:,i)=reshape(u1,nx,ny);
    v1=fid1(nx*ny+1:nx*ny*2,1);
    v(:,:,i)=reshape(v1,nx,ny);
    h1=fid1(2*nx*ny+1:nx*ny*3,1);    
    h(:,:,i)=reshape(h1,nx,ny);
    a=fclose(fid);
    i=i+1;
end
n
% h_2=h(101:end,140,:);
% h_2=reshape(h_2,[501,72,10]);
% h_2=sum(h_2,3)/10;
% h_2=reshape(h_2,[501,6,12]);
% h_2=sum(h_2,2)/6;
% h2_mean=reshape(h_2,[501,12]);
% h3=reshape(h(101:end,140,(end-71):end),[501,72]);
% for  j=1:12
%      h_a(:,j)=h3(:,6*(j-1)+1)-h2_mean(:,j);
% end
% h_a=[h_a';h_a'];
% contour(h_a)
% save('case250_h_a.mat','h_a')
% saveas(gca,'case250.jpg')
save('basic_uvh.mat','u','v','h');