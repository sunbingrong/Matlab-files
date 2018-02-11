function Chebyshev_Collocation_Method_Scalar_Equation_05231900
% Burgers_Equation
%   Q_t = [F(Q)]_x
%   Q(1,t) = Q(0,t);
%   Q(x,0) = g(x);  i.e. g(x) = sin(pi*x)
%   x = [-1,1]
% ====================================================
Problem          = 0      ;  % Problem_Type       : 0-Wave ; 1-Burgers
Amplitude        = 1      ;

N                = 64    ;  % number of points

Final_Time       = 0.45    ;
CFL              = 0.95   ;

Movie_Resolution = 0.05   ;

% ====================================================
[x, dx] =   Domain_Setup( N    ) ; 
[D, S ] = Operator_Setup( N, x ) ; 

      Q =  Initial_Condition (    x, 0 ) ;
      Q = Boundary_Condition ( Q, x, 0 ) ;

Step = 0; Time = 0; dt = Time_Step ( Q ) ;

% SIMPLE VERSION BELOW (Comment/Uncomment between the * lines)
% **************************BEGIN****SIMPLE VERSION***********************
while (Time < Final_Time)
  dt   = Time_Step ( Q )   ;
  Step = Step + 1 
  Time = Time + dt 

  Q = Runge_Kutta ( Q ) ;

    fprintf('Plot ... \n') ; plot(x, Q, 'o-'); grid on
    title(['t = ', num2str(Time, '%1.2f')]); 
    axis([-1,1,-(Amplitude+1),Amplitude+1]); %pause(0.01)
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
  function [x, dx] = Domain_Setup ( N )
    k = 0:N;

    x  = -cos(pi/N * k') ;

    dx = abs(x(2) - x(1)) ;
  end
% ================================================================
  function [D, S] = Operator_Setup ( N, x )
    k  = 0:N;  N_half = floor(N/2);

    c  = ones(1,N+1) ; c([1, N+1]) = 2 ;

    D =   Diff_Matrix ;     % Eq. (11.5)
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

      for i = 1,N_half + 1
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
      alpha = -log(1e-16); gamma = 20;

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
  function f = Exact_Solution( x, Time )
      x0 = -0.5; delta = 0.25 ; alpha = -log(1e-16) ; 
      
    if Problem == 0, f = exp(-alpha*((x-x0)/delta).^2); end
    if Problem == 1, f =  Amplitude*sin(pi*(x+Time)) ; end
  end
% ================================================================
  function f = Initial_Condition( x, Time )
    f   = Exact_Solution (x, Time);
  end
% ================================================================
  function dt = Time_Step ( Q )
    if Problem == 0, dt = CFL*dx          ; end
    if Problem == 1, dt = CFL*dx/(max(abs(Q(:,1)))) ; end
  end
% ================================================================
  function Q = Runge_Kutta ( Q )
    %  Stage 1
    t = Time;
    
    D_F = D_Fluxes( Q )            ;
    Q1  = Q + dt * D_F             ;

 %  Q1  = Filter( S, Q1 )            ;
    Q1  = Boundary_Condition ( Q1, x, t )      ;

    % Stage 2
    t = Time - dt/2;
    
    D_F = D_Fluxes( Q1 )               ;
    Q1  = (3*Q + Q1 + dt*D_F)/4        ;

%   Q1  = Filter( S, Q1 )            ;
    Q1  = Boundary_Condition ( Q1, x, t )      ;

    % Stage 3
    t = Time + dt;
    
    D_F = D_Fluxes( Q1 )             ;
    Q   = (Q + 2*Q1 + 2*dt*D_F)/3        ;

%   Q   = Filter( S, Q )             ;
    Q   = Boundary_Condition ( Q, x, t )       ;
  end
% ================================================================
  function D_F = D_Fluxes ( Q )
    if Problem == 0, F =    -Q    ; end
    if Problem == 1, F = 1/2*Q.^2 ; end

    D_F = D*F ;
  end
% ================================================================
  function Q = Filter( S, Q )
    Q = S*Q;
  end
% ================================================================
  function f = Boundary_Condition( f, x, t )   
    if Problem == 0, f(1)     = Exact_Solution( x(1), t)     ; end  
    if Problem == 1, f([1,N]) = 0                            ; end
  end
% ================================================================
  function S = Stability_Check
    if dt < 1.0e-14, error('=========  STOP ! Unstable  =============='); end
  end
% ================================================================
end
