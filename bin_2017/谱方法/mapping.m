% mapping
eps = 10^-17;
N = 257;
m = abs(log(eps))/N;
Map_alpha =  2/(exp(m)+exp(-m));
k = 0:N;
x  = -cos(pi/N * k') ;
x_map = asin(Map_alpha*x)/asin(Map_alpha);
D_map =  Map_alpha/asin(Map_alpha)*1./sqrt(1-(Map_alpha*x).^2);
Map   =  1./D_map;
plot(x,'o')
hold on
plot(x_map,'*')