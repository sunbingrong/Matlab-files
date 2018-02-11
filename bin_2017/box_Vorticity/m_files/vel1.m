clc
clear
dirs=dir('../Input/ERAs3_monmean_1959_2009.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;
%filename=textread('E:\papper\south_china_sea\seasonal_energy\outcome1\avedata\name.txt','%11c');
nx=761;
ny=241;

taux=zeros(nx,ny,12);tauy=zeros(nx,ny,12);
fid=fopen(strcat('../Input/',char(filenames(1))));
fid1=fread(fid,(nx*ny*12*2),'real*4');
for t = 1:12
start = nx*ny*2*(t-1);
u1=fid1(start+1:start+nx*ny,1);
taux(:,:,t)=reshape(u1,nx,ny);
v1=fid1(start+nx*ny+1:start+nx*ny*2,1);
tauy(:,:,t)=reshape(v1,nx,ny);
end
a=fclose(fid);

save('windstress.mat','taux','tauy');