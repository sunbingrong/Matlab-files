clear; clc
x_min = -1; x_max = 1;
for k = 1:5
    N(k) = 2^(k-1)*10;
    n = 1:N(k)+1;
    c = ones(1,N(k)+1);
    c(1) = 2 ; c(end) = 2;
    x(n) = -cos(pi*(n-1)/N(k));
    u = sin(x);
    D = zeros(length(n),length(n));
    
    for i = 1:length(n)
        for j = 1:length(n)
            if j == i
                D(i,j) = -x(i)/2/(1-x(i)^2);
            else
                D(i,j) = c(i)/c(j) * (-1)^(i+j)/(x(i)-x(j));
            end
        end
    end
    D(1,1) = -(2*N(k)^2+1)/6; D(end,end) = (2*N(k)^2+1)/6;
    
    for i = 1:length(n)
        D(i,i) = - sum(D(i,:)) + D(i,i); 
    end
    diff_u_app = D*u';
    diff_u_exa = cos(x)';
    error(k) = sqrt(sum((abs(diff_u_app - diff_u_exa)).^2));
    %xlim([0,1])
    %plot(x,diff_u_app,'-o',x,diff_u_exa,'-*');
end
semilogy(N,error,'-ro');
xlim([N(1),N(end)])
