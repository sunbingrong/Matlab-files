x=[1:100];
y=rand(1,100);
plot(x,y,'-ro')
set(gca,'XTick',0:5:100);
%rang = 0:5:100;
set(gca,'xminortick','on') 
%set(gca,'XTickLabel',rang);