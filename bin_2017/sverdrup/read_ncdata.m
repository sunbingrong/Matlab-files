%% 读取ssh数据
clc;  %清屏
clear; %清空
datadir='D:\Matlab2014b\bin\bin文件\bin（2015）\Test\sverdrup\data\ssh\'; %指定批量数据所在的文件夹
filelist=dir([datadir,'*.nc']); %指定批量数据的类型
%a=filelist(1).name; %查看你要读取的文件的编号。filelist(1).name在window下为第一个标号数据
%b=filelist(2).name; %查看你要读取的文件的编号。filelist(2).name在window下为第二个标号数据
k=length(filelist);
for s=1:k
  filename=[datadir,filelist(s).name];
  ncid=netcdf.open(filename,'NC_NOWRITE');
  % ncdisp('D:\data\降水数据\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc'); %在命令窗中显示nc文件的变量
  % 任意取其中一个来看数据中所包含的变量特征，以为下面读取数据变量做铺垫
  % ncid = netcdf.open('D:\data\降水数据\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc','NOWRITE'); %打开nc文件
  % ncdisp('D:\data\降水数据\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc'); %在命令窗中显示nc文件的变量
  ssh(s).A = ncread(filename,'sshg');
  %eval(['sshg',num2str(s), '=  ncread(filename,''sshg'');' ])   %读入
  netcdf.close(ncid);   % 关闭文件
end
%% 读取salt数据
clc;  %清屏
clear; %清空
datadir='D:\Matlab2014b\bin\bin文件\bin（2015）\Test\sverdrup\data\salt\'; %指定批量数据所在的文件夹
filelist=dir([datadir,'*.nc']); %指定批量数据的类型
%a=filelist(1).name; %查看你要读取的文件的编号。filelist(1).name在window下为第一个标号数据
%b=filelist(2).name; %查看你要读取的文件的编号。filelist(2).name在window下为第二个标号数据
k=length(filelist);
for s=1:k
  filename=[datadir,filelist(s).name];
  ncid=netcdf.open(filename,'NC_NOWRITE');
  % ncdisp('D:\data\降水数据\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc'); %在命令窗中显示nc文件的变量
  % 任意取其中一个来看数据中所包含的变量特征，以为下面读取数据变量做铺垫
  % ncid = netcdf.open('D:\data\降水数据\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc','NOWRITE'); %打开nc文件
  % ncdisp('D:\data\降水数据\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc'); %在命令窗中显示nc文件的变量
  %salt(s).A = ncread(filename,'salt');
  eval(['salt',num2str(s), '=  ncread(filename,''salt'');' ])   %读入
  netcdf.close(ncid);   % 关闭文件
end