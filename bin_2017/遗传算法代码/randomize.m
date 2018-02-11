function B = randomize(A,rowcol)
% Usage: B = randomize(A,rowcol)
% randomize row orders or column orders of A matrix
% rowcol: if = 0 or omitted, row order (default)
% if = 1, column order 
rand('state',sum(100*clock)*rand(1))       %产生随时间变化的随机数
if nargin == 1 
    rowcol = 0;
end
if rowcol == 0 
    [m,n] = size(A);                       %m必须大于1
    p = rand(m,1); 
    [p1,I] = sort(p); 
    B = A(I,:);
else rowcol == 1
    Ap = A'; 
    [m,n] = size(Ap); 
    p = rand(m,1); 
    [p1,I] = sort(p); 
    B = Ap(I,:)';
end