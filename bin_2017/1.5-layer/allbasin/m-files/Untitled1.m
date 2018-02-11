clear
syms y t A B L r

a0 = 10.43*10^(8); a1 = -27.39*10^(8);
c0 = -1.07*10^(8); c1 = 5.09*10^(-7);
b1 = 21.87*10^(8); d1 = -0.39*10^(8);
A  = 0.2*(1+0.025.*(y-7))*10^(-7); B = 3.5*A;
phy = 60; L = 40./(1-(y-15)/20); alpha = 4;
AH = 3; S = 30;
r = alpha*pi./L;
omega = 2*pi/1;

z(y,t) = (S/pi)^(4)*(r*A*sin(omega*phy)*cos(2*pi.*(y-15)/L)+(1-r*r)*B*sin(2*pi*(y-15)/L))/AH ...
    -(a0+a1*cos(pi*y/S)+b1*sin(pi*y/S))*cos(omega*t) ...
    -(c0+c1*cos(pi*y/S)+d1*sin(pi*y/S))*sin(omega*t);