
% This program calls the routines to read Microwave-only OI SST products  or 
% Microwave-IR OI SST products available from RSS
%
% Change the file_name below to point to your data file 
% comment out that which you don't need
%
% Questions should be addressed to RSS support: 
% http://www.remss.com/support


% CHANGE to your directory and file (UNZIPPED):  currently set to OI verification data file
file_name = 'your drive:\your directory\mw.fusion.2004.140.v04.0';
sst = read_rss_mw_sst(file_name);
sst(770:775,474:478)'



% CHANGE to your directory and file (UNZIPPED):  currently set to MW-IR verification data file
file_name = 'D:/Microwave Optimally Interpolated SST/MW_ir/2002/mw_ir.fusion.2002.152.v04.0/mw_ir.fusion.2002.152.v04.0';
sst = read_rss_mw_sst(file_name);
example_sst = sst';
example_sst(example_sst>=40)=nan;  %默认数值为255
contourf(example_sst)

WOA13_directory = 'D:/WOA/WOA13/Month Mean/';
sst_01 = ncdisp([WOA13_directory,'t01an1']);

