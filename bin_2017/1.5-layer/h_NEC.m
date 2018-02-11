% »­hµÄÍ¼
clear
load('vel.mat')
h1=h(100:700,135,:);
h1=reshape(h1,[601,360]);
h2=reshape(h1,[601,1,30,12]);
h2=reshape(h2,[601,30,12]);
h2_mean=sum(h2,2)/30;
for  j=1:12
     h_a(:,j)=h1(:,30*(j-1)+1)-h2_mean(:,j);
end
h_a=[h_a';h_a'];
% x = 1:601;
% y = 1:12;
% [X,Y] = meshgrid(x,y);
% v = [1,1];
% figure
%contour(X,Y,h_a',v)
contourf(h_a)
saveas(gcf,'a.jpg')
save('h_a.mat','h_a')