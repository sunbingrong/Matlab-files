%为了得到气候态的边界条件
clc
clear
dirs=dir('/home/user/sbr/sbr/1.5-layer/avedata/basic/*.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;   
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;
%filename=textread('E:\papper\south_china_sea\seasonal_energy\outcome1\avedata\name.txt','%11c');
nx=761;
ny=221;
n=length(filenames);
u=zeros(nx,ny,3600);v=zeros(nx,ny,3600);
h=zeros(nx,ny,3600);
i=1;
for t=3601:n
    fid=fopen(strcat('/home/user/sbr/sbr/1.5-layer/avedata/basic/',char(filenames(t))));
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
umean_140E=sum(u(161,:,:),3)/3600;
vmean_140E=sum(v(161,:,:),3)/3600;
hmean_140E=sum(h(161,:,:),3)/3600;
save('umean_140E.mat','umean_140E');
save('vmean_140E.mat','vmean_140E');
save('hmean_140E.mat','hmean_140E');