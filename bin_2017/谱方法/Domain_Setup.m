    function [x, dx, y, dy] = Domain_Setup ( N, M )
        k = 0:N; j=0:M;
        
        x  = -cos(pi/N * k') ;
        y  = -cos(pi/M * j') ;
        
        dx = abs(x(2:end) - x(1:end-1)) ;
        dy = abs(y(2:end) - y(1:end-1)) ;
    end