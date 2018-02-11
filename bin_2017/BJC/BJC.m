%% fig 1
for n=1:3
b=0:2:10;
c=1./(1+b/(n*pi));
plot(b,c)
hold on
end