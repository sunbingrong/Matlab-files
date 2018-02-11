vflx1=vflx(:,:,1);
vflx1=[vflx1 vflx1(:,94) vflx1(:,94)];
x=length(vflx1(:,1));
 y=length(vflx1(1,:));
 new_vflx1=zeros(192*5,96*5);
new_vflx1(1,1)=vflx1(1,1);
for j=2:y
    new_vflx1(1,5*j)=vflx1(1,j);
end
for i=2:x
    new_vflx1(5*i,1)=vflx1(i,1);
end
for i=2:x
    for j=2:y
        new_vflx1(5*i,5*j)=vflx1(i,j);
    end
end
new_vflx1(1,1:10)=linspace(new_vflx1(1,1),new_vflx1(1,10),10);
for j=2:y-1
    new_vflx1(1,5*j:5*(j+1))=linspace(new_vflx1(1,5*j),new_vflx1(1,5*(j+1)),6);
end
new_vflx1(10,1:10)=linspace(new_vflx1(10,1),new_vflx1(10,10),10);
for i=3:x
    new_vflx1(5*i,1:10)=linspace(new_vflx1(5*i,1),new_vflx1(5*i,10),10);
end
for i=2:x
    for j=2:y-1
        new_vflx1(5*i,5*j:5*(j+1))=linspace(new_vflx1(5*i,5*j),new_vflx1(5*i,5*(j+1)),6);
    end
end
for j=1:5*y
     new_vflx1(1:10,j)=linspace(new_vflx1(1,j),new_vflx1(10,j),10);
end
for i=2:x-1
    for j=1:5*y
        new_vflx1(5*i:5*(i+1),j)=linspace(new_vflx1(5*i,j),new_vflx1(5*(i+1),j),6);
    end
end