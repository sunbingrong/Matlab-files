
N                = 257   ;  % number of x points
M                = 128   ;  % number of y points

a                = 0.5   ;
b                = 0.5   ;

k = 0:N; j=0:M;

x  = -cos(pi/N * k') ;
y  = -cos(pi/M * j') ;
N_half = floor(N/2);

c = ones(1,N+1) ; c([1, N+1]) = 2 ;
theta = pi/(2*N);

D  = zeros(N+1)  ;
for i = 1:N_half + 1
    for j = 1:N+1
        if i ~= j
            factor = c(i)/c(j)*(-1)^(i+j);
            D(i,j) = factor/(2*sin(((i-1)+(j-1))*theta)*sin(((i-1)-(j-1))*theta));
        elseif i == 1
            D(i,j) = -(2*N^2 + 1)/6;
        else
            D(i,j) = - x(i)/(2*sin(pi/N*(i-1))^2);
        end
    end
end

for i = 1:N_half + 1
    D(i,i) = -(sum(D(i,1:i-1)) + sum(D(i,i+1:N+1)));
end

for i = N_half+2 : N+1
    for j = 1:N+1
        D(i,j) = - D(N+2-i,N+2-j);
    end
end

E_D = zeros(N+1,N_half+1);
O_D = zeros(N+1,N_half+1);

for i = 1:N+1
    E_D(i,:) = D(i,1:N_half+1) - D(N+2-i,1:N_half+1);
    O_D(i,:) = D(i,1:N_half+1) + D(N+2-i,1:N_half+1);
end

Q = rand(N+1,M+1);

F =    -Q    ;
F_x_even = F(2:2:N+1,:);
F_x_odd  = F(1:2:N+1,:);

D_F = a*(E_D*F_x_even + O_D*F_x_odd) + b*(D_y*F')' ;