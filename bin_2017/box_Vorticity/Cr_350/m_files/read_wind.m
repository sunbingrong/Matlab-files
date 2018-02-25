clc
clear
dirs=dir('/home/user/sbr/sbr/Vorticity/Input/modelwind_quar_monthlyclim.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б?���ؽṹ���顣
dircell=struct2cell(dirs)' ;   
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ��������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ�������
%�����ļ�vel.mat;
%filename=textread('E:\papper\south_china_sea\seasonal_energy\outcome1\avedata\name.txt','%11c');
nx=761;
ny=221;
n=length(filenames);
taux=zeros(nx,ny,12);
tauy=zeros(nx,ny,12);
for i=1:12
    fid=fopen(strcat('/home/user/sbr/sbr/Vorticity/Input/modelwind_quar_monthlyclim.dat'));
    fid1=fread(fid,(nx*ny*24),'real*4');
    u1=fid1(nx*ny*(2*i-2)+1:nx*ny*(2*i-1),1);
    taux(:,:,i)=reshape(u1,nx,ny);
    u2=fid1(nx*ny*(2*i-1)+1:nx*ny*2*i,1);
    tauy(:,:,i)=reshape(u2,nx,ny);
    a=fclose(fid);
end

save('/home/user/sbr/sbr/Vorticity/Input/windstress.mat','taux','tauy');
