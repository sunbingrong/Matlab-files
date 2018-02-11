function show_circle_line=show_matrix(circle_line,L)
global circlelength;
[x,y]=size(circle_line);
show_circle_line=0.8*ones(y,x,3);
R=circle_line;
G=circle_line;
B=circle_line;
R(R>0)=R(R>0)/L;
R(R<-880)=0;
R(R<0)=0.8;
R(R==0)=1;

G(G>0)=1-G(G>0)/L;
G(G<-880)=0;
G(G<0)=0.8;
G(G==0)=1;

B(B>0)=B(B>0)/(2*L);
B(B<-880)=0;
B(B<0)=0.8;
B(B==0)=1;

show_circle_line(:,:,1)=R;
show_circle_line(:,:,2)=G;
show_circle_line(:,:,3)=B;
