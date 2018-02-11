function bifurPHI = bifurcation_NPacific(vv,topo,point)   % bj:original bifur j index  bj1:optimized bifur j index

%--------------N pacific---------------------------------------

minv=10;   % given a larger value

for j=75:126  %(8.75-18.75~N)  it can be modified if needed

iocean = 200;
while (topo(iocean,j)==1)
iocean=iocean-1;
end

sumv=0;
for i=iocean:iocean+point
sumv = sumv + vv(i,j);
end

if(abs(sumv)<minv)
minv = abs(sumv);
minj = j;
end

end

bj=minj;  % non-optimized j


%--- now we can get minj, next step is find the adjusent abs value
%--- left
iocean = 200;
while (topo(iocean,minj-1)==1)
iocean = iocean-1;
end

sumv=0.;
for i=iocean:iocean+point  %(2 band) it can be modified if needed
sumv=sumv+vv(i,minj-1);
end

minv1=abs(sumv);
%--- right
iocean=200;
while (topo(iocean,minj+1)==1)
iocean=iocean-1;
end

sumv=0;
for i=iocean:iocean+point  %(2 band) it can be modified if needed
sumv=sumv+vv(i,minj+1);
end

minv2=abs(sumv);

%---------ok, we get three values and then calculate the optimized j
%--form a new array
a11=(minj-1)^2;
a12=minj-1;
a13=1;
a21=minj^2;
a22=minj;
a23=1;
a31=(minj+1)^2;
a32=minj+1;
a33=1;
Y1=minv1;
Y2=minv;
Y3=minv2;
%--- use cramer law---
%-- get value of determinant, we don't need to get D3
D = a11*a22*a33+a12*a23*a31+a13*a21*a32-a13*a22*a31-a12*a21*a33-a11*a23*a32;
D1= Y1*a22*a33+a12*a23*Y3+a13*Y2*a32-a13*a22*Y3-a12*Y2*a33-Y1*a23*a32;
D2= a11*Y2*a33+Y1*a23*a31+a13*a21*Y3-a13*Y2*a31-Y1*a21*a33-a11*a23*Y3;
%-- we can obtain the coefficient
a=D1/D;
b=D2/D;
%-- optimized j can be obtained
bj_opt=-1*b/(2*a);

%--convert to lat
bifurPHI=(bj_opt-1)*0.2+(-6);