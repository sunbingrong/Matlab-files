function y = rshift(x,dir)
% Usage: y = rshift(x,dir)
% rotate x vector to right (down) by 1 if dir  =  0 (default)
% or rotate x to left (up) by 1 if dir  =  1 
if nargin==1
    dir = 0; 
end 
[m,n] = size(x); 
if m>1 
    if n  ==  1
       col = 1; 
    else 
         error('x must be a vector! break'); 
    end % x is a column vector 
else  m  ==  1
        if n  ==  1
            y = x; 
        return 
        else n>1
            col = 0;  % x is a row vector
        end
end 
% judge the type of x,row vector or column vector
if dir == 1   % rotate left or up 
    if col == 0  % row vector, rotate left 
        y  =  [x(2:n) x(1)]; 
    else
        y  =  [x(2:m);x(1)]; % rotate up 
    end
else  dir==0  % default rotate right or down
    if col == 0 
        y  =  [x(n) x(1:n-1)]; 
    else  col==1 % column vector 
        y  =  [x(m);x(1:m-1)]; 
    end
end
