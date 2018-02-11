%数据 ： 5.2N-20.2N 120.2E-132.2E
% 深度40层 5m——5375m
clear;clc;
load('each_depth.mat');
y = 18; %18N
delta_x = 6.371e6*cos(y*pi/180)*(0.25*pi/180);
nx = 256;  ny = 306; nz = 12;
for i = 1:12
    data = cell2mat(struct2cell(load(['../Output/ne2_1111',num2str(i,'%02d'),'_v_nec.mat'])));
    v_total = data(132:144,52:67,3:20);  % 16N-20N 122E-130E 1m-381m
    %v_total = data(135:137,52:67,3:20);  % 16N-20N 122E-130E 1m-381m
    [nx,ny,nz] = size(v_total);
    v1 = reshape(nanmean(v_total,1),[ny nz]);
    v1(isnan(v1))=0;
    total_trans(i,:) = sum(v1*each_depth(3:nz+3-1)'*delta_x);
    plot(total_trans)
    xlim([1 12]);
end