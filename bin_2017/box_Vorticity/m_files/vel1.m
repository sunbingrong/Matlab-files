clc
clear
dirs=dir('../Input/ERAs3_monmean_1959_2009.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)' ;
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;
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