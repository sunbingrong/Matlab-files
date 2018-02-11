yearday=365+zeros(1,40);
modelday=[1:14610];
nday=0;
for i=1974:2014
    if mod(i,4)==0
        yearday(i-1973)=366;
    end
end
for m=1:40
    modelday(nday+1:nday+yearday(m)) = circshift(modelday(nday+1:nday+yearday(m)),[0,30]);
    nday=nday+yearday(m);
end
%%
fid=fopen('b.txt','w');
fprintf(fid,'%g\t',modelday);
fclose(fid);
