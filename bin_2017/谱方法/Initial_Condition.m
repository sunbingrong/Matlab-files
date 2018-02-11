    function f = Initial_Condition( x, y )
        %f = Exact_Solution (x, Time)
        eps = 10^(-16); beta = 0.25; omega = 8;
        alpha  = -log(eps);
        R      =  beta*min(abs(x(end)-x(1)),abs(y(end)-y(1)));
        x_c    =  x(1) + R; y_c = y(1) + R;
        r      =  zeros(length(x),length(y));
        for r_i = 1:length(x)
            for r_j = 1:length(y)
                r(r_i,r_j)      =  sqrt((x(r_i)-x_c).^2+(y(r_j)-y_c).^2);
            end
        end
        f      =  exp(-alpha*(r/R).^omega);
    end