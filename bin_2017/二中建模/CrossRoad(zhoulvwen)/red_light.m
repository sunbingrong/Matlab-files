function  [new,t]=red_light(old,line_width,line_length,t,dt)
a=line_length+1:line_length+line_width;
b=line_length-line_width;
new=old;
t=t+1;
dela=10;
if t==dt
    new(b-1,a)=new(b-1,a)-888;
    new(end-b+2,a+line_width+1) = new(end-b+2,a+line_width+1)-888;
    t=-dt;
end

if t==(-dt+dela)&sum(new(a+line_width+1,b-1)<-88)>0
   new(a+line_width+1,b-1) = new(a+line_width+1,b-1)+888;
   new(a,end-b+2) = new(a,end-b+2)+888;
end


if t==0
   new(a+line_width+1,b-1) = new(a+line_width+1,b-1)-888;
   new(a,end-b+2) = new(a,end-b+2)-888;
end

if t==dela&sum(new(b-1,a)<-88)>0
   new(b-1,a)=new(b-1,a)+888;
   new(end-b+2,a+line_width+1) = new(end-b+2,a+line_width+1)+888;
end
