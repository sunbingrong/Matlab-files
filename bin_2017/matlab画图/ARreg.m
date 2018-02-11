function [ARreg,ARloc]=ARreg(timeseris2,timeseris1,lt,ut,bm)
%% This function aims to do lead-lag regression
%=========================================================================%
% Copyright Daling L. Yi    2013.05
%
% USAGE:  [ARreg,ARloc]=ARreg(timeseris2,timeseris1,lt,ut,bm)
%
% timeseris  timeseris2=ARreg*timeseries1,both should be Nx1 array
% lt         lag time£¨Äê¡¢ÔÂ¡¢ÈÕ£©, lt<0.
% ut         lead time £¨timeseris1 lead timeseris2£©, ut>0
% bm         lead-lag interval,bm=1,means "month";bm=12,means "year".
%            if the timeseries are both monthly data.
% ARreg      regressiong coefficient 
% ARloc      regressiong coefficient which signficant at 95% confidence level.
%            ARloc=1   signficant     ;ARloc=0   insignficant
%
%=========================================================================%
%%

t=length(timeseris1);
k=1;
for i=lt:bm:ut;
    if i<0
    [B,BINT,R] =regress(timeseris2(1:(t+i)),[ones(t+i,1) timeseris1((-i+1):t)]); 
    
    if BINT(2,2)*BINT(2,1)>0;
    ARreg(k)=B(2);ARloc(k)=1;
    else
    ARreg(k)=B(2);ARloc(k)=0;    %%%  insignficant ==0
    end
    
    else
    [B,BINT,R] =regress(timeseris2((i+1):t),[ones(t-i,1) timeseris1(1:(t-i))]); 
    
    if BINT(2,2)*BINT(2,1)>0;
    ARreg(k)=B(2);ARloc(k)=1;
    else
    ARreg(k)=B(2);ARloc(k)=0;    
    end
    
    end
    k=k+1;
end
clear t k i