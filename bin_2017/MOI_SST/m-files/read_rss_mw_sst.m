% read_rss_mwoi_sst.m
%
% This subroutine reads unzipped RSS Microwave-only (MW) and Microwave-IR (MWIR) Optimal Interpolated SST fusion files (version-4.0)
% RSS files must be unzipped before reading with this function
%
% Input argument:
% file name = the full path and name of the unzipped data file
%
% The MW-IR data files consist of 3 arrays sized 4096x2048 (~9km earth grid)
% The MW-only data files consist of 3 arrays sized 1440x720 (0.25 deg grid)
%
% The function returns:
% sst = array of real SST values
% error = array of interpolation error 
% mask = array data mask
%
%
% The mask should be used to identify sea ice, land, bad data.  
% Mask values are:
% Bit 0 = land
% Bit 1 = sea ice
% Bit 2 = IR satellite data used
% Bit 3 = MW satellite data used
% Bit 4 = near-land suspect data mask (for MW OISSTs)
% Bit 5 = unclassified sea ice near land, could be ice or not  (only applies to MW-IR product, not used for MW-only product)
% Bit 6 = not used
% Bit 7 = not used
%
% In this sample program the mask values are used to set data in the SST and Error arrays to:
%      252 = sea ice
%      254 = missing data, near land
%      255 = land mass
%
% xcell = grid cell values between 1 and xmax (where xmax = 4096 or 1440)
% ycell = grid cell values between 1 and ymax (where ymax = 2048 or 720)
% dx=360./xmax
% dy=180./ymax
% Center of grid cell Longitude  = dx*xcell-dx/2.    (degrees east)
% Center of grid cell Latitude   = dy*ycell-(90+dy/2.)  (-90 to 90)
%
%
% To create a TEST OUTPUT IMAGE use:
% [sst,error,mask]=read_rss_mwoi_sst(file_name);
% str={'Land','Ice','IR data','MW data','Bad data'};
% figure(1);subplot(2,1,1),imagesc(sst',[-3 34]);subplot(2,1,2),imagesc(sst',[250 255]);
% figure(2);for i=1:5,ilnd=bitget(mask,i);subplot(1,5,i),imagesc(ilnd',[0 1]);title(str{i});end;
% figure(3);subplot(2,1,1),imagesc(error',[0 1.1]);subplot(2,1,2),imagesc(error',[250 255]);
%
% for a detailed description see: http://www.remss.com/measurements/sea-surface-temperature and click on Documentation
%
% questions should be addressed to RSS support:
% http://www.remss.com/support
%
% 4/2010 c.gentemann
% updated to version 4.0,  11/2014 d.smith


function [sst,error,mask]=read_rss_mw_sst(file_name)

%[file_name]=unzipfile(file_name);  %if you want to write an unzip function
centigrade_scale_sst   = .15;
centigrade_offset_sst  = -3;
centigrade_scale_error = .005;
centigrade_offset_error= 0;

if ~exist(file_name)
   error = ['file not found: ', file_name]
   sst=[];error=[];mask=[];
   return;
end;

%determine array size from file name
file_name;
ia=findstr('mw_ir',file_name);
if length(ia)<1,
    xdim=1440;
    ydim=720;
else
    xdim=4096;
    ydim=2048;
end;

%read data from file

fid = fopen(file_name, 'r');
sst = fread(fid,[xdim ydim], 'uchar');
error = fread(fid,[xdim ydim], 'uchar');
mask = fread(fid,[xdim ydim], 'uchar');
fclose(fid);

%scale SST
good = find(sst <= 250);
sst(good) = (sst(good) * centigrade_scale_sst) + centigrade_offset_sst;

%scale error
good = find(error <= 250);
error(good) = (error(good) * centigrade_scale_error) + centigrade_offset_error;

%set flags in SST and error fields using the mask data
land=find(bitget(mask,1)==1);sst(land)=255;error(land)=255;
ice =find(bitget(mask,2)==1);sst(ice)=252;error(ice)=252;
bad =find(bitget(mask,5)==1);sst(bad)=254;error(bad)=254;
pos_ice=find(bitget(mask,6)==1)';sst(pos_ice)=252;error(pos_ice)=252;

return;
