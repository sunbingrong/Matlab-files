%% 示例程序
[X,Y] = meshgrid(90:-2.5:-90,0:2.5:357.5);
Z=uwmd;
[XI,YI] = meshgrid(90:-0.75:-90,0:0.5:360);
ZZ = interp2(X,Y,Z,XI,YI);
%% 转换格式
save xx.dat variable -ascii
%% 差值地形
[X,Y] = meshgrid(0:1/6:40,100:1/6:220);
Z=topo_NPC';
[XI,YI] = meshgrid(0:0.25:40,100:0.25:220);
topo_test = interp2(X,Y,Z,XI,YI);
%% 处理数据
clc
clear
dirs=dir('D:/Matlab2014b/bin/bin文件/bin(2015)/Test/风应力数据(2006-2014)/风应力数据/*.nc');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
 dircell=struct2cell(dirs)';
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames = dircell(:,1) % 第一列是文件名
%读取流速数据
%保存文件vel.mat;
%filename=textread('E:\papper\south_china_sea\seasonal_energy\outcome1\avedata\name.txt','%11c');
nx=721;
ny=241;
u=zeros(nx,ny,1);v=zeros(nx,ny,1);
for t=1:1
    fid=fopen(strcat('C:/Users/ouc-ice/Desktop/',char(filenames(t))));
    fid1=fread(fid,(nx*ny*3),'real*8');
    u1=fid1(1:nx*ny,1);
    u(:,:,t)=reshape(u1,nx,ny);
    v1=fid1(nx*ny+1:nx*ny*2,1);
    v(:,:,t)=reshape(v1,nx,ny);
    h1=fid1(2*nx*ny+1:nx*ny*3,1);    
    h(:,:,t)=reshape(h1,nx,ny);
    a=fclose(fid);
end
save('vel.mat','u','v','h');
%% 存储.mat文件（风数据）
clc;  %清屏
clear; %清空
datadir='E:\data\2006-2014wind\'; %指定批量数据所在的文件夹
filelist=dir([datadir,'*.nc']); %指定批量数据的类型
%k=length(filelist);
for s=1:9
    year=2005+s;
    filename=[datadir,filelist(s).name];  %查看你要读取的文件的编号。filelist(1).name在window下为第一个标号数据
    WindData  = ncread(filename,'uwnd');  %读入变量precip
    taux=WindData(:,:,1,:);
    taux=taux(:,:,:);
    for i=1:365
    [X,Y] = meshgrid(90:-2.5:-90,0:2.5:357.5);
    Z=taux(:,:,i);
    [XI,YI] = meshgrid(90:-0.25:-90,0:0.25:357.5);
    ZZ = interp2(X,Y,Z,XI,YI);
        eval(['save u' num2str(year) '-' num2str(i) ' ZZ;']);
    end
end
for s=1:9
    year=2005+s;
    filename=[datadir,filelist(s+9).name];   
    WindData  = ncread(filename,'vwnd'); %读入变量precip
    taux=WindData(:,:,1,:);
    taux=taux(:,:,:);
    for i=1:365
    [X,Y] = meshgrid(90:-2.5:-90,0:2.5:357.5);
    Z=taux(:,:,i);
    [XI,YI] = meshgrid(90:-0.25:-90,0:0.25:357.5);
    ZZ = interp2(X,Y,Z,XI,YI);
        eval(['save v' num2str(year) '-' num2str(i) ' ZZ;']);
    end
end
%% 
for k=1
    for i=1
        load(['u' num2str(k+2005) '-' num2str(i) '.mat']);
        ZZ=ZZ(401:)
    end
end
%% 转为.dat文件
for k=1:9
    for i=1:365
        load(['u' num2str(k+2005) '-' num2str(i) '.mat']);
        ZZ=double(ZZ);
        save(['u' num2str(k+2005) '-' num2str(i) '.dat'],'ZZ','-ascii');
    end
end