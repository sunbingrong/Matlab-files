syms x
r=taylor(exp(x),x,'order',20);
simulate=subs(r,x,pi);
vpa(simulate,10)
