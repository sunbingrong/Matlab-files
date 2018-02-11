
% This program calls the routines to read Microwave-only OI SST products  or
% Microwave-IR OI SST products available from RSS
%
% Change the file_name below to point to your data file
% comment out that which you don't need
%
% Questions should be addressed to RSS support:
% http://www.remss.com/support
% CHANGE to your directory and file (UNZIPPED):  currently set to OI verification data file

% Calculate Climatology SST
clc
clear
lon = double(ncread('../Output/REMSS-L4_GHRSST-SSTfnd-MW_OI-GLOB-v02.0-fv05.0.nc','lon'));
lat = double(ncread('../Output/REMSS-L4_GHRSST-SSTfnd-MW_OI-GLOB-v02.0-fv05.0.nc','lat'));
lon = lon + 180;
k = 0;
x = length(lon); y =length(lat);
MOI_SST_2002_2013 = zeros(x,y,12);
for year = 2002:2013
    k = k+1;
    dirs = dir(['../Input/',num2str(year),'/SST_',num2str(year),'/*.0']);
    % ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
    dircell=struct2cell(dirs)' ;
    % �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
    filenames=dircell(:,1) ; % ��һ�����ļ���
    n = length(filenames);
    sst = zeros(x,y);
    for t = 1:n
        filenames(t)
        sst = sst + read_rss_mw_sst(['../Input/',num2str(year),'/SST_',num2str(year),'/',char(filenames(t))]);
    end
    MOI_SST_2002_2013(:,:,k) = sst/n;
end
save('../Output/MOI_SST_2002_2013.mat','MOI_SST_2002_2013');
save('../Output/MOI_SST_lon.mat','lon');
save('../Output/MOI_SST_lat.mat','lat');