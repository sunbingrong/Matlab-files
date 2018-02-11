function x = dichotomy(fun, a, b, eps)
% 二分法求方程的根
% Input  -fun 方程对应的函数 -(a, b) 根所在的区间 -eps 精度
% Output -x   近似根
if nargin < 4, eps = 1e-4; end
s = sign(feval(fun, a));
t = sign(feval(fun, b));
if s * t >= 0, error('出错了'); end
x = (a + b)/2;
while abs(feval(fun, x)) > eps || abs(a - b) > eps
    if sign(feval(fun,x)) == s
        a = x;
    else
        b = x;
    end
    x = (a + b)/2;
end