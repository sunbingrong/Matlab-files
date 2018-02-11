clc
clear
dirs=dir('/home/user/wangsp/Model/reduced/reduced_400_sea/outcome/avedata/*.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б������ؽṹ���顣
dircell=struct2cell(dirs)' ;   
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;
%filename=textread('E:\papper\south_china_sea\seasonal_energy\outcome1\avedata\name.txt','%11c');
nx=241;
ny=81;

u=zeros(nx,ny,648);v=zeros(nx,ny,648);
for t=1:720
    fid=fopen(strcat('/home/user/wangsp/Model/reduced/reduced_400_sea/outcome/avedata/',char(filenames(t))));
    fid1=fread(fid,(nx*ny*3),'real*4');
    u1=fid1(1:nx*ny,1);
    u(:,:,t)=reshape(u1,nx,ny);
    v1=fid1(nx*ny+1:nx*ny*2,1);
    v(:,:,t)=reshape(v1,nx,ny);
    h1=fid1(2*nx*ny+1:nx*ny*3,1);    
    h(:,:,t)=reshape(h1,nx,ny);
    a=fclose(fid);
end

save('vel.mat','u','v','h');