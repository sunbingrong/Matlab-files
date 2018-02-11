function x = dichotomy(fun, a, b, eps)
% ���ַ��󷽳̵ĸ�
% Input  -fun ���̶�Ӧ�ĺ��� -(a, b) �����ڵ����� -eps ����
% Output -x   ���Ƹ�
if nargin < 4, eps = 1e-4; end
s = sign(feval(fun, a));
t = sign(feval(fun, b));
if s * t >= 0, error('������'); end
x = (a + b)/2;
while abs(feval(fun, x)) > eps || abs(a - b) > eps
    if sign(feval(fun,x)) == s
        a = x;
    else
        b = x;
    end
    x = (a + b)/2;
end