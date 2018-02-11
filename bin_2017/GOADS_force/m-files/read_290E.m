clear;clc;
load('../Output/uub_290E.mat'); load('../Output/vvb_290E.mat');
load('../Output/hhb_290E.mat');load('D:\Applications\Matlab2015b\bin\bin文件\bin（2015）\SODA_force\Output\hhb.mat');
contourf(hhb_290E(:,:,end)')
ny = 221; nx = 761;
hhb1 = hhb;
hhb1(hhb1==0)=nan;
for j = 1:ny
    for t = 1:12
        for i = 1:nx
            SODA_h_a(i,j,t) = hhb1(i,j,t) - nanmean(hhb1(:,j,t));
        end
    end
    j
end

[im,jm,tm] = size(SODA_h_a);
fid = fopen('../Input/hhb_a.dat','wb');
for i=1:tm
    aa = reshape(SODA_h_a(:,:,i),[1 im*jm]);
    fwrite(fid,aa,'real*4');
end
fclose(fid)
%% 比较hhb_SODA与hhb_180E的数值 10N-25N
hhb_SODA_change = hhb(201,121:161,3) - 350;
hhb_SODA_change = smooth(hhb_SODA_change,20);
subplot(1,2,1)
plot(hhb_SODA_change);
xlim([1 61])
subplot(1,2,2)
hhb_180E = hhb_290E(201,121:161,3);
plot(hhb_180E);
xlim([1 61])