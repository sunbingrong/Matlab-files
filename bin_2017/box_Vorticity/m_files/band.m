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
%假如T=20days，那么(1:N/2+1)<1/T)

Wf(find(freq(1:N/2+1)<1/T1&freq(1:N/2+1)>1/T2))=f(find(freq(1:N/2+1)<1/T1&freq(1:N/2+1)>1/T2));  
%  表示大于20天的信号保留（不包含20天）
% Wf=f;
ASf=ifft(Wf);
LAf=real(ASf);
%%%%%%% output
lvt=(LAf+mean(b))';
%%%%%%%
clear a N f freq Wf ASf LAf T aa b