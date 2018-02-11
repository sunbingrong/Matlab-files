function [L1,L2] = crossgens(X1,X2)
% Usage:[L1,L2] = crossgens(X1,X2)
[r1,N]=size(X1);N=N-1;
s = randomize([2:N]')';
n1 = min(s(1),s(N-1));
n2 = max(s(1),s(N-1));
B1 = X1(n1:n2);B2 = X2(n1:n2);
[r3,m]=size(B1);
t1=zeros(m,1);t2=zeros(m,1);
for i=n1:n2
        [s1,t1(i-n1+1)]=find(X2(1,:)==X1(1,i));
        [p1,I1]=sort(t1);
        [s2,t2(i-n1+1)]=find(X1(1,:)==X2(1,i));
        [p2,I2]=sort(t2);
end
for i=1:m
    B1(i)=X2(p1(i));
    B2(i)=X1(p2(i));
end
L1=X1;L2=X2;
L1(n1:n2)=B1;
L2(n1:n2)=B2;
    
        