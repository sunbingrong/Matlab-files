function [pres,dens]=my_pressure(depth,ssh,temp,salt,lat)
 n=length(depth);
 pres=zeros(n,1);
 pres2=sw_pres(depth,lat);
 while max(abs(pres2-pres))>0.01
    pres=pres2;
    dens=sw_dens(salt,temp,pres);
    pres2(1)=sw_pres(ssh,lat)+dens(1)*9.8*depth(1)/10000;
    for i=2:n
        pres2(i)=pres2(i-1)+0.5*(dens(i)+dens(i-1))*9.8*(depth(i)-depth(i-1))/10000;
    end 
 end
    