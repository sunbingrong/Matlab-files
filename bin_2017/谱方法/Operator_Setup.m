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
  