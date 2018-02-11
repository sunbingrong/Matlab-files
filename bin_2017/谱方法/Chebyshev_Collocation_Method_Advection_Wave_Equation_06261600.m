function Chebyshev_Collocation_Method_Advection_Wave_Equation_06261600

% Advection_Wave_Equation
%  - Q_t = a*[F(Q)]_x + b*[F(Q)_y]
%    Q(x_l,y,t) = 0;
%    Q(x,y_b,t) = Q(x,y_t,t);
%    Q(x,y,0)   = f(x,y);
%   i.e. f(x,y) = exp[-alpha*(r/R)^omega]
%             x = [-1,1],y = [-1,1]
% ====================================================

N                = 257   ;  % number of x points
M                = 128   ;  % number of y points

xl               = -1    ;  % x-axis Left
xr               =  1    ;  % x-axis Right
yb               = -1    ;  % y-axis Bottom
yt               =  1    ;  % y-axis Top

a                = 0.5   ;
b                = 0.5   ;

Final_Time       = 0.5  ;
CFL              = 1.0  ;

beta             = 0.25   ; % parameter in the initial condition
omega            = 8      ; % parameter in the initial condition

% ====================================================
[x, dx, y, dy] = Domain_Setup( N, M ) ;
[X,Y]       = meshgrid(x,y);
[D_x, S_x ] = Operator_Setup( N, x) ;
[D_y, S_y ] = Operator_Setup( M, y) ;

Q =  Initial_Condition ( x, y ) ;

Step = 0; Time = 0; dt = Time_Step;

t = Time;

Q = Boundary_Condition ( Q ) ;

% SIMPLE VERSION BELOW (Comment/Uncomment between the * lines)
% **************************BEGIN****SIMPLE VERSION***********************
while (Time < Final_Time)
    dt   = Time_Step;
    Step = Step + 1;
    Time = Time + dt;
    
    Q = Runge_Kutta ( Q ) ;
    fprintf('Plot ... \n') ; surf(X,Y,Q'); grid on
    title(['t = ', num2str(Time, '%1.2f')]);
    %axis([-1,1,-1,1]);
    pause(0.01)
end
    Q_exact = Exact_Solution(x,y,Time);
    max(max(Q - Q_exact))
%subplot(1,2,2)
%plot(Error,'o');
% ***********************END HERE****************************************

fprintf('Done ... \n');

% ================================================================
    function [x, dx, y, dy] = Domain_Setup ( N, M )
        k = 0:N; j=0:M;
        
        x  = -cos(pi/N * k') ;
        y  = -cos(pi/M * j') ;
        
        %dx = abs(x(2) - x(1)) ;
        %dy = abs(y(2) - y(1)) ;
        
        dx = abs(x(2:end) - x(1:end-1)) ;
        dy = abs(y(2:end) - y(1:end-1)) ;
    end
% ================================================================
    function [D, S] = Operator_Setup ( N, x )
        k = 0:N;  N_half = floor(N/2);
        
        c = ones(1,N+1) ; c([1, N+1]) = 2 ;
        
        D = Diff_Matrix ;     % Eq. (11.5)
        S = Filter_Matrix ;
        
        % ========================================
        function D = Diff_Matrix
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
            
        end
        % ========================================
        function S = Filter_Matrix
            alpha = -log(1e-16); gamma = 16;
            
            sigma = exp(-alpha * abs(k/N).^gamma);
            
            S = zeros(N+1);
            for i = 1:N+1
                for j = 1:N+1
                    Ti     = cos(k*pi/N*(i-1));
                    Tj     = cos(k*pi/N*(j-1));
                    S(i,j) = 2/(N*c(j))* sum(sigma./c.*Tj.*Ti);
                end
            end
            
        end
        
    end
% ================================================================
    function f = Exact_Solution( x, y, Time )
        eps   = 1e-16;
        alpha = -log(eps);
        R     = beta * min(abs(xr-xl), abs(yt-yb));
        xc    = xl + R;
        yc    = yb + R;
        r = zeros(length(x),length(y));
        f = zeros(length(x),length(y));
        for i = 1:length(x)
            for j = 1:length(y)
                r(i,j)     = sqrt((x(i)-a*Time-xc).^2 + (y(j)-b*Time-yc).^2);
                f(i,j)     = exp(-alpha * (r(i,j)/R).^omega);
            end
        end
    end
% ================================================================
    function f = Initial_Condition( x, y )
        eps = 10^(-16);
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
% ================================================================
    function dt = Time_Step
        %h  =  abs(a/dx)+abs(b/dy);
        h  =  abs(a/min(dx))+abs(b/min(dy));
        dt = CFL/h ;
    end
% ================================================================
    function Q = Runge_Kutta ( Q )
        %  Stage 1
        t = Time;
        
        D_F = D_Fluxes( Q )            ;
        Q1  = Q + dt * D_F             ;
        
        %Q1  = Filter( S_x, S_y, Q1 )            ;
        Q1  = Boundary_Condition ( Q1 )      ;
        
        % Stage 2
        t = Time - dt/2;
        
        D_F = D_Fluxes( Q1 )               ;
        Q1  = (3*Q + Q1 + dt*D_F)/4        ;
        
        %Q1  = Filter( S_x, S_y, Q1 )            ;
        Q1  = Boundary_Condition ( Q1 )      ;
        
        % Stage 3
        t = Time + dt;
        
        D_F = D_Fluxes( Q1 )             ;
        Q   = (Q + 2*Q1 + 2*dt*D_F)/3        ;
        
        %Q   = Filter( S_x, S_y, Q )             ;
        Q   = Boundary_Condition ( Q )       ;
    end
% ================================================================
    function D_F = D_Fluxes ( Q )
        F =  Q    ;
        D_F = a*D_x*F + b*F*D_y' ;       % un-mapping
        %D_F = a*Map_x*D_x*F + b*(Map_y*D_y*F')' ;  % with mapping
        D_F = - D_F;
    end
% ================================================================
    function Q = Filter( S_x, S_y, Q )
        Q = S_x*Q*S_y';
    end
% ================================================================
    function Map = Map( x, N )
        eps = 10^(-16);
        m =  abs(log(eps))/N;
        Map_alpha =  2/(exp(m)+exp(-m));
        D_map =  Map_alpha/asin(Map_alpha)*1./sqrt(1-(Map_alpha*x).^2);
        diag_Map   =  1./D_map;
        Map = zeros(N+1,N+1);
        for i = 1:length(x)
            Map(i,i) = diag_Map(i);
        end
    end
% ================================================================
    function f = Boundary_Condition( f )
        f(1,:) = 0; f(:,1) = f(:,end);
    end
% ================================================================
end
