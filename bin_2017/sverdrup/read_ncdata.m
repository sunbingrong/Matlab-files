%% ��ȡssh����
clc;  %����
clear; %���
datadir='D:\Matlab2014b\bin\bin�ļ�\bin��2015��\Test\sverdrup\data\ssh\'; %ָ�������������ڵ��ļ���
filelist=dir([datadir,'*.nc']); %ָ���������ݵ�����
%a=filelist(1).name; %�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
%b=filelist(2).name; %�鿴��Ҫ��ȡ���ļ��ı�š�filelist(2).name��window��Ϊ�ڶ����������
k=length(filelist);
for s=1:k
  filename=[datadir,filelist(s).name];
  ncid=netcdf.open(filename,'NC_NOWRITE');
  % ncdisp('D:\data\��ˮ����\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc'); %���������ʾnc�ļ��ı���
  % ����ȡ����һ�������������������ı�����������Ϊ�����ȡ���ݱ������̵�
  % ncid = netcdf.open('D:\data\��ˮ����\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc','NOWRITE'); %��nc�ļ�
  % ncdisp('D:\data\��ˮ����\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc'); %���������ʾnc�ļ��ı���
  ssh(s).A = ncread(filename,'sshg');
  %eval(['sshg',num2str(s), '=  ncread(filename,''sshg'');' ])   %����
  netcdf.close(ncid);   % �ر��ļ�
end
%% ��ȡsalt����
clc;  %����
clear; %���
datadir='D:\Matlab2014b\bin\bin�ļ�\bin��2015��\Test\sverdrup\data\salt\'; %ָ�������������ڵ��ļ���
filelist=dir([datadir,'*.nc']); %ָ���������ݵ�����
%a=filelist(1).name; %�鿴��Ҫ��ȡ���ļ��ı�š�filelist(1).name��window��Ϊ��һ���������
%b=filelist(2).name; %�鿴��Ҫ��ȡ���ļ��ı�š�filelist(2).name��window��Ϊ�ڶ����������
k=length(filelist);
for s=1:k
  filename=[datadir,filelist(s).name];
  ncid=netcdf.open(filename,'NC_NOWRITE');
  % ncdisp('D:\data\��ˮ����\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc'); %���������ʾnc�ļ��ı���
  % ����ȡ����һ�������������������ı�����������Ϊ�����ȡ���ݱ������̵�
  % ncid = netcdf.open('D:\data\��ˮ����\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc','NOWRITE'); %��nc�ļ�
  % ncdisp('D:\data\��ˮ����\CPC Unified Gauge-Based Analysis of Daily Precipitation over CONUS\precip.V1.0.1948.nc'); %���������ʾnc�ļ��ı���
  %salt(s).A = ncread(filename,'salt');
  eval(['salt',num2str(s), '=  ncread(filename,''salt'');' ])   %����
  netcdf.close(ncid);   % �ر��ļ�
end