load A
C = A;
[m,n] = size(A);
a = 0;
for i = 2:m-1
    for j = 2:n-1
        B = A(i-1:i+1,j-1:j+1)
        if (B(5) == 0 && all(B([1:4,6:end]) ~= 0)), C(i,j) = B(1);a = a + 1, end
    end
end
D = C;
for i = 2:m-1
    for j = 2:n-1
        B = C([i-1:i+1,j-1:j+1]);
        if (B(5) == 0 && all(B([1:4,6:end]) ~= 0)), D(i,j) = B(1); a = a + 1, end
    end
end