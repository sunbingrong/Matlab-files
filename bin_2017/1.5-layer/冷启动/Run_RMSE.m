%% bifur画进一张图
clc
clear
dirs=dir('D:/Matlab2014b/bin/bin文件/bin（2015）/1.5-layer/各实验分叉点/*.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;   
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;
c=zeros(13,12);
error=zeros(12,12);
for t=1:length(filenames)
    a=char(filenames(t));
    fid = load(a);
    bifur = fid(5401:end,2);
    a=reshape(bifur,[30,12,5]);
    b=sum(a,3)/5;
    c(t,:)=sum(b)/30;
end
for i=1:12
    error(i,:)=c(i+1,:)-c(1,:);
end
    RMSE=sqrt(sum(error.*error,2)/12);
    plot(RMSE,'bo-')
    xlim([1 12])