function [x_out,tr]=xxhg(yyyy)
% xxhg   
%================================================================
% xxhg  Date: 2010/06/07 13:00
%           Copyright (C) zhchen
%
% USAGE:  [x_out,tr]=xxhg(yyyy)
%         yyyy = input a 1D data


l=length(yyyy);
xxxx=1:l;
xv=mean(xxxx);
yv=mean(yyyy);

dxx=0;
dxy=0;
for i=1:l
    q=xxxx(i)-xv;
    dxx=dxx+q^2;
    dxy=dxy+q*(yyyy(i)-yv);
end

A=dxy/dxx;
B=yv-A*xv;

% calculate trend
for i=1:l
    tr(i)=A*xxxx(i);
end

tr=tr+B;

% calculate data without trend
for i=1:l
    y1(i)=yyyy(i)-tr(i);
end
% detrend
x_out     =y1'+B;






