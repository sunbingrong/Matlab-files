function [x,y,Q,Error] = Center_difference_Method_Advection_Wave_Equation_06261600

%  - Q_t = a*[F(Q)]_x + b*[F(Q)_y]
%    Q(x_l,y,t) = 0;
%    Q(x,y_b,t) = Q(x,y_t,t);
%    Q(x,y,0)   = f(x,y);
%   i.e. f(x,y) = exp[-alpha*(r/R)^omega]
%             x = [-1,1],y=[-1,1]

N                = 257   ;  % number of x points
M                = 128   ;  % number of y points

xl               = -1    ;  % x-axis Left
xr               =  1    ;  % x-axis Right
yb               = -1    ;  % y-axis Bottom
yt               =  1    ;  % y-axis Top

a                = 0.5   ;
b                = 0.5   ;

Final_Time       = 1.5    ;
CFL              = 1.0    ;

beta             = 0.25   ; % parameter in the initial condition
omega            = 8      ; % parameter in the initial condition

[x, dx, y, dy] =   Domain_Setup( N, M ) ;

D_x = Operator_Setup( N ) ;
D_y = Operator_Setup( M ) ;

Q =  Initial_Condition ( x, y ) ;

Step = 0; Time = 0; dt = Time_Step ;

t = Time;

Q = Boundary_Condition ( Q ) ;

while (Time < Final_Time)
    dt   = Time_Step;
    Step = Step + 1;
    Time = Time + dt
    
    Q = Runge_Kutta ( Q ) ;
    [X,Y] = meshgrid(x,y);
    subplot(1,2,1)
    fprintf('Plot ... \n') ; surf(X,Y,Q'); grid on
    title(['t = ', num2str(Time, '%1.2f')]);
    %axis([-1,1,-(Amplitude+1),Amplitude+1]); %pause(0.01)
    %axis([-1,1,-1,1]);
end

Q_exact = Exact_Solution(x,y,Time);
Error   = max(max(Q - Q_exact)) ;

fprintf('Done ... \n');

% ================================================================
    function [x, dx, y, dy] = Domain_Setup ( N, M )
        
        x  = linspace(xl,xr,N+1);
        y  = linspace(yb,yt,M+1);
        
        dx = abs(x(2) - x(1)) ;
        dy = abs(y(2) - y(1)) ;
    end
% ================================================================
    function D = Operator_Setup ( N )
        D = zeros(N+1,N+1);
        for i = 2:N
            D(i,i-1) = -1;
            D(i,i+1) = 1;
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
% ================================================================
    function dt = Time_Step
         h = abs(a/dx)+abs(b/dy);
        dt = CFL/h ;
    end
% ================================================================
    function Q = Runge_Kutta ( Q )
        %  Stage 1
        t = Time;
        
        D_F = D_Fluxes( Q )            ;
        Q1  = Q + dt * D_F             ;
        
        Q1  = Boundary_Condition ( Q1 )      ;
        
        % Stage 2
        t = Time - dt/2;
        
        D_F = D_Fluxes( Q1 )               ;
        Q1  = (3*Q + Q1 + dt*D_F)/4        ;
    
        Q1  = Boundary_Condition ( Q1 )      ;
        
        % Stage 3
        t = Time + dt;
        
        D_F = D_Fluxes( Q1 )             ;
        Q   = (Q + 2*Q1 + 2*dt*D_F)/3        ;
        
        Q   = Boundary_Condition ( Q )       ;
    end
% ================================================================
    function D_F = D_Fluxes ( Q )
         F = -Q;
       D_F = a/(2*dx)*(D_x*F)+ b/(2*dy)*(F*D_y') ;
    end
% ================================================================
    function f = Boundary_Condition( f )
        f(1,:) = 0; f(end,:) = 0;
        f(:,1) = 0; f(:,end) = 0;
    end
% ================================================================
end

