x=0:0.1:10;
y=x.^2+1;
plot(x,y)
set(gca, 'XTick', [0 1 2]); 
set(gca, 'XTickLabel', {'a','b','c'})
