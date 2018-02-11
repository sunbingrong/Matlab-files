%% ʾ������
[X,Y] = meshgrid(90:-2.5:-90,0:2.5:357.5);
Z=uwmd;
[XI,YI] = meshgrid(90:-0.75:-90,0:0.5:360);
ZZ = interp2(X,Y,Z,XI,YI);
%% ת����ʽ
save xx.dat variable -ascii
%% ��ֵ����
[X,Y] = meshgrid(0:1/6:40,100:1/6:220);
Z=topo_NPC';
[XI,YI] = meshgrid(0:0.25:40,100:0.25:220);
topo_test = interp2(X,Y,Z,XI,YI);
%% ��������
clc
clear
dirs=dir('D:/Matlab2014b/bin/bin�ļ�/bin(2015)/Test/��Ӧ������(2006-2014)/��Ӧ������/*.nc');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
 dircell=struct2cell(dirs)';
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames = dircell(:,1) % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;
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
%% �洢.mat�ļ��������ݣ�
clc;  %����
clear; %���
datadir='E:\data\2006-2014wind\'; %ָ�������������ڵ��ļ���
filelist=dir([datadir,'*.nc']); %ָ���������ݵ�����
%k=length(filelist);
for s=1:9
    year=2005+s;
    filename=[datadir,filelist(s).name];  %�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
    WindData  = ncread(filename,'uwnd');  %�������precip
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
    WindData  = ncread(filename,'vwnd'); %�������precip
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
%% תΪ.dat�ļ�
for k=1:9
    for i=1:365
        load(['u' num2str(k+2005) '-' num2str(i) '.mat']);
        ZZ=double(ZZ);
        save(['u' num2str(k+2005) '-' num2str(i) '.dat'],'ZZ','-ascii');
    end
end