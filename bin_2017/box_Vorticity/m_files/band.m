function lvt=band(tseries,lt,ht)
a=tseries;
T1=lt ;% days or months or year .....
T2=ht;
%%%%%%%
b=a;
a=a-mean(a);
N=length(a);
f=fft(a);
f=2*f;

freq=(0:N-1)/1/N;
Wf=zeros(1,N);
%����T=20days����ô(1:N/2+1)<1/T)

Wf(find(freq(1:N/2+1)<1/T1&freq(1:N/2+1)>1/T2))=f(find(freq(1:N/2+1)<1/T1&freq(1:N/2+1)>1/T2));  
%  ��ʾ����20����źű�����������20�죩
% Wf=f;
ASf=ifft(Wf);
LAf=real(ASf);
%%%%%%% output
lvt=(LAf+mean(b))';
%%%%%%%
clear a N f freq Wf ASf LAf T aa b