clc
clear
dirs=dir('E:/fortran代码/my_model1/my_model1/output/*.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;   
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;
%filename=textread('E:\papper\south_china_sea\seasonal_energy\outcome1\avedata\name.txt','%11c');
nx=960;
ny=72;
u=zeros(nx,ny,360);v=zeros(nx,ny,360);

for t=1:360
    fid=fopen(strcat('E:/fortran代码/my_model1/my_model1/output/',char(filenames(t))));
    fid1=fread(fid,nx*ny*3,'real*4');
    u1=fid1(1:nx*ny,1);
    u(:,:,t)=reshape(u1,nx,ny);
    v1=fid1(nx*ny+1:nx*ny*2,1);
    v(:,:,t)=reshape(v1,nx,ny);
    h1=fid1(2*nx*ny+1:nx*ny*3,1);    
    h(:,:,t)=reshape(h1,nx,ny);
    a=fclose(fid);
end

save('vel.mat','u','v','h');
%% read ACC
clc
clear
dirs=dir('E:/fortran代码/my_model1/my_model1/model_ACC/*.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;   
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;
%filename=textread('E:\papper\south_china_sea\seasonal_energy\outcome1\avedata\name.txt','%11c');
nx=960;
ny=72;
u=zeros(nx,ny,1);v=zeros(nx,ny,1);

for t=1
    fid=fopen(strcat('E:/fortran代码/my_model1/my_model1/model_ACC/',char(filenames(t))));
    fid1=fread(fid,nx*ny*3,'real*4');
    u1=fid1(1:nx*ny,1);
    u(:,:,t)=reshape(u1,nx,ny);
    v1=fid1(nx*ny+1:nx*ny*2,1);
    v(:,:,t)=reshape(v1,nx,ny);
    h1=fid1(2*nx*ny+1:nx*ny*3,1);    
    h(:,:,t)=reshape(h1,nx,ny);
    a=fclose(fid);
end

save('vel.mat','u','v','h');