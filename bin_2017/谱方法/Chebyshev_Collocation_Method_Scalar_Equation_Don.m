function Chebyshev_Collocation_Method_Scalar_Equation_Don
% 2D wave equation
%   Q_t + [F(Q)]_x + [G(Q)]_y = 0
%    where F(Q) = a * Q, G(Q) = b * Q
%   I.C. Q(x,y,0) = f(x,y)
%   B.C. Q(x,yb,t) = Q(x,yt,t), Q(xl,y,t) = 0
%   x in [xl,xr], y in [yb,yt]
% ====================================================

N                = 256   ;  % number of points in x direction is N + 1
M                = 128   ;  % number of points in y direction is M + 1
xl               = -1    ;
xr               =  1    ;
yb               = -1    ;
yt               =  1    ;

a                = 0.5   ; % constant speed of propagation in x direction
b                = 0.5   ; % constant speed of propagation in y direction

Final_Time       = 0.5    ;
CFL              = 1.0    ;
beta             = 0.25   ; % parameter in the initial condition
omega            = 8      ; % parameter in the initial condition
gamma            = 16     ; % filtering of order

Movie_Resolution = 0.05   ;

% ====================================================
xi =   Domain_Setup( N    ) ;
eta =   Domain_Setup( M    ) ;
[x, dx, Mx] = Mapping( N, xi    ) ;
[y, dy, My] = Mapping( M, eta    ) ;
[Dx, Sx ] = Operator_Setup( N, Mx ) ;
[Dy, Sy ] = Operator_Setup( M, My ) ;
[X,Y]     = Grid_Setup(x,y);


Q =  Initial_Condition ( X, Y ) ;
Q = Boundary_Condition ( Q ) ;

mesh(X, Y, Q);

pause(0.1)
Step = 0; Time = 0; dt = Time_Step ( dx, dy ) ;

% SIMPLE VERSION BELOW (Comment/Uncomment between the * lines)
% **************************BEGIN****SIMPLE VERSION***********************
while (Time < Final_Time)
    dt   = Time_Step ( dx, dy )   ;
    Step = Step + 1          ;
    Time = Time + dt         ;
    
    Q = Runge_Kutta ( Q ) ;
    Q_E = Exact_Solution( X, Y, Time );
    norm(Q_E - Q, inf)
    fprintf('Plot ... \n') ; mesh(X, Y, Q); grid on
    title(['t = ', num2str(Time, '%1.2f')]);
    %axis([-1,1,-(Amplitude+1),Amplitude+1]);
    pause(0.01)
end
% ***********************END HERE*****************************************

% NOT SO SIMPLE VERSION BELOW (Uncomment between the * lines)
% **************************BEGIN* NOT SO SIMPLE VERSION******************
%disp(['Estimate Number of Time Step : ', num2str(fix((Final_Time-Time)/dt))])
%disp(' Total_Step    Step     dt    Time    CPU Time')
%disp('--------------------------------------------------------------------------')
%formatstr = '  %7d %7d %13.4E %13.4E %13.4E %13.4E %13.4E';
%fprintf(formatstr, fix((Final_Time-Time)/dt), Step, dt, Time, 0, 0)
%fprintf('\n')
%
%Next_Save_Time = Time +  Movie_Resolution;
%
%CPU_Begin = cputime;
%while (Time < Final_Time)
%  dt   = Time_Step ( Q )   ;
%  Step = Step + 1 Time = Time + dt ;
%
%  Stability_Check
%
%  Save_Indicator = 0;
%  if (Time >= Next_Save_Time)
%    dt   = dt - (Time-Next_Save_Time);
%    Time = Next_Save_Time;
%    Save_Indicator = 1;
%    Next_Save_Time = Next_Save_Time + Movie_Resolution;
%  end
%
%  if Time > Final_Time, dt = dt - (Time - Final_Time); Time = Final_Time; end
%
%  Q = Runge_Kutta ( Q ) ;
%
%  if (Save_Indicator)
%    if P_Type == 0
%      Q_E   = Exact_Solution( x, Time )   ;
%      Error = norm(Q-Q_E, inf); disp(Error) ;
%    end
%    fprintf('Plot ... \n') ; plot(x, Q, '-'); grid on
%    title(['t = ', num2str(Time, '%1.2f')]);
%    axis([-1,1,-(Amplitude+1),Amplitude+1]);
%    pause(0.001)
%  end
%
%  fprintf(formatstr, fix((Final_Time-Time)/dt), Step, dt, ...
%    Time, CPU_End-CPU_Start, CPU_End-CPU_Begin)
%  fprintf('\n')
%end
% ***********************END HERE****************************************

fprintf('Done ... \n');

% ================================================================
    function x = Domain_Setup ( N )
        k = 0:N;
        
        x  = -cos(pi/N * k') ;
    end
% ================================================================
    function [X,Y] = Grid_Setup(x,y)
        X = zeros(N+1,M+1); Y = zeros(N+1,M+1);
        for j = 1:M+1
            X(:,j) = x;
        end
        for i = 1:N+1
            Y(i,:) = y;
        end
    end
% ================================================================
    function [x, dx, Map] = Mapping( N, xi    )
        alpha = sech(abs(log(1e-16))/N);
        x = asin(alpha * xi) / asin(alpha);
        
        dx = x(2) - x(1);
        
        Map            = zeros(N+1);
        C              = asin(alpha) / alpha;
        Map(1:N+2:end) = C * sqrt( 1 - (alpha * xi).^2 );
    end
% ================================================================
    function [D, S] = Operator_Setup ( N, Map )
        k  = 0:N;  N_half = floor(N/2);
        
        c  = ones(1,N+1) ; c([1, N+1]) = 2 ;
        
        D =   Diff_Matrix ;     % Eq. (11.5)
        D = Map * D       ;
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
                        D(i,j) = cos(pi/N * (i-1))/(2*sin(pi/N*(i-1))^2);
                    end
                end
            end
            
            for i = 1 : N_half + 1
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
            alpha = -log(1e-16);
            
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
    function f = Initial_Condition( x, y )
        eps = 1e-16;
        alpha = -log(eps);
        R = beta * min(abs(xr-xl), abs(yt-yb));
        xc = xl + R;
        yc = yb + R;
        r = sqrt((x-xc).^2 + (y-yc).^2);
        f = exp(-alpha * (r/R).^omega);
        f(r>R) = 0;
    end
% ================================================================
    function dt = Time_Step ( dx, dy )
        dt = CFL / (a/dx + b/dy) ;
    end
% ================================================================
    function Q = Runge_Kutta ( Q )
        %  Stage 1
        t = Time;
        
        D_F = D_Fluxes( Q )            ;
        Q1  = Q + dt * D_F             ;
        
        %  Q1  = Filter( S, Q1 )            ;
        Q1  = Boundary_Condition ( Q1 )      ;
        
        % Stage 2
        t = Time - dt/2;
        
        D_F = D_Fluxes( Q1 )               ;
        Q1  = (3*Q + Q1 + dt*D_F)/4        ;
        
        %   Q1  = Filter( S, Q1 )            ;
        Q1  = Boundary_Condition ( Q1 )      ;
        
        % Stage 3
        t = Time + dt;
        
        D_F = D_Fluxes( Q1 )             ;
        Q   = (Q + 2*Q1 + 2*dt*D_F)/3        ;
        
        % Q = Filter( S, Q )             ;
        %Q   = Filter( Sx, Q, Sy )              ;
        Q   = Boundary_Condition ( Q )       ;
    end
% ================================================================
    function D_F = D_Fluxes ( Q )
        F = a * Q ;
        G = b * Q ;

        D_F_x = Dx * F ;
        D_F_y = G * Dy' ; % == (Dy * G')' ;
        
        D_F = - (D_F_x + D_F_y);
        
    end
% ================================================================
    function Q = Filter( Sx, Q, Sy )
        %Q = Sx * Sy * Q ; % * Sy' ;
        Q = Sx * Q  * Sy' ;
    end
% ================================================================
    function Q = Exact_Solution( x, y, time )
        eps = 1e-16;
        alpha = -log(eps);
        R = beta * min(abs(xr-xl), abs(yt-yb));
        xc = xl + R;
        yc = yb + R;
        r = sqrt((x-a*time-xc).^2 + (y-b*time-yc).^2);
        Q = exp(-alpha * (r/R).^omega);
    end
% ================================================================
    function Q = Boundary_Condition( Q )
        Q(:,1) = Q(:,M+1);
        Q(1,:) = 0;
    end
% ================================================================
    function S = Stability_Check
        if dt < 1.0e-14, error('=========  STOP ! Unstable  =============='); end
    end
% ================================================================
end
