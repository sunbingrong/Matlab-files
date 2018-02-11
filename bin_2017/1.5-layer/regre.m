function regre(price,score)
load price
load score
% figure
% plot(price,score,'o')
% n = length(price)
% X = [ones(n,1),price(:)];
% Y = score(:);
% ALPHA = 0.05;
% [B,BINT,R,RINT,STATS] = regress(Y,X,ALPHA)
% figure
% rcoplot(R,RINT)
%%
% n = length(price)
% price(4) = []; score(4) = [];
% X = [ones(n-1,1),price(:)];
% 
% Y = score(:);
% ALPHA = 0.10;
% [B,BINT,R,RINT,STATS] = regress(Y,X,ALPHA)
% figure
% rcoplot(R,RINT)
%%
n = length(price)
X = [ones(n,1),score(:)];
Y = price(:);
ALPHA = 0.05;
[B,BINT,R,RINT,STATS] = regress(Y,X,ALPHA)
figure
plot(score,price,'o')
hold on
YY = B(1) + B(2)*X(:,2);
plot(X(:,2),YY,'r')
figure
rcoplot(R,RINT)