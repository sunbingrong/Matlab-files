clear;clc
for k = 1:5
    N(k) = 2^(k+1);
    X = 0:2*pi/N(k):2*pi;
    M = 1000;
    % u = 3/(5-4*cos(x));
    x = 0:2*pi/M:2*pi;
    for i = 1:M+1
        sum = 0;
        for j = -N(k)/2:N(k)/2
                g = 2^(-abs(j));
            sum = sum + g*cos(j*x(i));
        end
        u_app(i) = sum;
        sum_exact(i) = 3/(5-4*cos(x(i)));
    end
    subplot(1,2,1)
    plot(x/(2*pi),u_app,x/(2*pi),sum_exact)
    error = abs(u_app-sum_exact);
    subplot(1,2,2)
    semilogy(x/(2*pi),error);
    %xlim([0,1])
    hold on
end

h = legend(strcat('$$ N = ', num2str(N'), ' $$'));
set(h, 'interp', 'latex', 'orientation', 'horizontal', 'location', 'best')