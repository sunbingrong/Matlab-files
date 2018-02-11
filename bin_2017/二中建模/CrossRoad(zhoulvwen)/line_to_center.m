function new=line_to_center(old, line_length, line_width)
new=old;
a=line_length+1:line_length+line_width;
b=line_length-line_width;
for i=a
    if new(b+1,i)==0&new(b,i)>0
       new(b+1,i)=new(b,i);
       new(b,i)=0;
    end
  
    if new(end-b,i+line_width+1)==0&new(end-b+1,i+line_width+1)>0
       new(end-b,i+line_width+1)=new(end-b+1,i+line_width+1);
       new(end-b+1,i+line_width+1)=0;
    end
    
    if new(i+line_width+1,b+1)==0&new(i+line_width+1,b)>0
       new(i+line_width+1,b+1)=new(i+line_width+1,b);
       new(i+line_width+1,b)=0;
    end
  
    if new(i,end-b)==0&new(i,end-b+1)>0
       new(i,end-b)=new(i,end-b+1);
       new(i,end-b+1)=0;
    end
end


for i=a
    if new(b,i+line_width+1)==0&new(b+1,i+line_width+1)==3
       new(b,i+line_width+1)=new(b+1,i+line_width+1);
       new(b+1,i+line_width+1)=0;
    end
    if new(end-b+1,i)==0&new(end-b,i)==1
       new(end-b+1,i)=new(end-b,i);
       new(end-b,i)=0;
    end
    
    if new(i,b)==0&new(i,b+1)==2
       new(i,b)=new(i,b+1);
       new(i,b+1)=0;
    end
  
    if new(i+line_width+1,end-b+1)==0&new(i+line_width+1,end-b)==4
       new(i+line_width+1,end-b+1)=new(i+line_width+1,end-b);
       new(i+line_width+1,end-b)=0;
    end
end
% new(i,b) = 0;
% new(a+line_width+1,end)=0;
% new(1,a+line_width+1) = 0;
% new(end,a)=0;