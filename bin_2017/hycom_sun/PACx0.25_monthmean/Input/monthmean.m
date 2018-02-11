data.plon = load('E:\J.W\DATA\PACx0.25\monthmean\hycom.plon');
data.plat = load('E:\J.W\DATA\PACx0.25\monthmean\hycom.plat');
data.u    = load('E:\J.W\DATA\PACx0.25\monthmean\01-19u3d.0011_04.dat');
data.v    = load('E:\J.W\DATA\PACx0.25\monthmean\01-19v3d.0011_04.dat');

data.hh   = load('E:\J.W\DATA\PACx0.25\monthmean\01-19thknss3d.0011_04.dat');
data.hh(data.hh<0)=nan;
data.hh(data.hh>1000)=nan;
data.hh = data.hh;
data.u(abs(data.u)>1.5)=nan;
data.v(abs(data.v)>1.5)=nan;
data.plon(isnan(data.u))=nan;
data.plat(isnan(data.v))=nan;
figure(1)
n=1;
quiver(data.plon(1:n:end,1:n:end),data.plat(1:n:end,1:n:end),data.u(1:n:end,1:n:end),data.v(1:n:end,1:n:end),4)
xlim([120 130])
ylim([8 20])