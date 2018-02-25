function y=low_pass(x,n)
% low_pass   get high passed value from the data
%================================================================
% Seacycle  Date: 2010/01/16 14:00
%           Copyright (C) zhchen
%
% USAGE:  y=low_pass(x,n)
%         x = input time series
%         n = n data period 
a=x;
T=n ;% days or months or year .....
%%%%%%%
b=a;
%a=normal(aa);
a=a-mean(a);
N=length(a);
f=fft(a);
f=2*f;
freq=(0:N-1)/1/N;
Wf=zeros(1,N);
%  ����T=20days����ô(1:N/2+1)<1/T)
Wf(find(freq(1:N/2+1)<1/T))=f(find(freq(1:N/2+1)<1/T));  %  ��ʾ����20����źű�����������20�죩
% Wf=f;
ASf=ifft(Wf);
LAf=real(ASf);
ida1f=(LAf+mean(b))';
%%%%%%%
y=ida1f;