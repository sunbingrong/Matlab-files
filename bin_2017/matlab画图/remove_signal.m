function [field_re]=remove_signal(index,field,lag)
%% This function aims to remove the given signal from field/variable
%=========================================================================%
% Copyright Daling L. Yi    2014.10 
%
% USAGE:  [field_re]=remove_signal(index,field,lag)
%
% index : the timeseries of the given signal which should be removed
%         (n) ,n means the samples number
% field : the field or variable 
%         (m,n), m means the varibles ,n means the samples number.
% lag   : the lead or lag signal will be removed
%         lag>0, means index lag
%         lag<0, means field lag
%         lag=0, means the simultanous signal will be removed
%=========================================================================%

%%
[m,n]=size(field);
[n1]=size(index,1);

if (n~=n1)  
    disp('The input is error, please check the variables!')
end

for i=1:m
     disp(['Progress: ' num2str(i/m*100) '%'])
    if lag>=0 
    [B,BINT,R,RINT,STATS] = regress(field(i,1:n-lag)',[ones(n-lag,1) index(lag+1:n)]);
    else 
    [B,BINT,R,RINT,STATS] = regress(field(i,-lag+1:n)',[ones(n+lag,1) index(1:n+lag)]);
    end
    reg2(i)=B(2);
    reg1(i)=B(1);
    field_inf(i,:) = reg2(i)*index+reg1(i);
    field_re(i,:) = field(i,:)-field_inf(i,:);
end
    