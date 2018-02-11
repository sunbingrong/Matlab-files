function new = new_cars(old, entry, line_length, line_width, allow_left)
new = old;
p=0.9;
k=3;
if allow_left == 0
    k=2;
end

if entry > 0
   if entry <= line_width;
      x = randperm(line_width);
      y = line_length;
      for i = 1:entry
      new((y + x(i)),end) = ceil(k*rand)*(rand>p);
      if k==2&new((y + x(i)),end)==1
         new((y + x(i)),end)=3;
      end
      
      
      new(y+line_width+1+x(i),1) = ceil(k*rand)*(rand>p);
      if new(y+line_width+1+x(i),1)==2
         new(y+line_width+1+x(i),1)=4;
      end
      
      new(1,(y + x(i))) = ceil(k*rand)*(rand>p);
      if new(1,(y + x(i)))==3
         new(1,(y + x(i)))=4;
      end
      
      new(end,y+line_width+1+x(i)) = ceil(k*rand)*(rand>p);
      if new(end,y+line_width+1+x(i))==1
         new(end,y+line_width+1+x(i)) =4;
      end
      if k==2&new(end,y+line_width+1+x(i))==2
         new(end,y+line_width+1+x(i)) =3;
      end
      
      end
   end
   if entry > line_width;
      y = line_length;
      for i = 1:line_width
          new((y + i),end) = ceil(k*rand)*(rand>p);

          
          new(y+line_width+1+i,1) = ceil(k*rand)*(rand>p);
          if new(y+line_width+1+i,1)==2
             new(y+line_width+1+i,1)=4;
          end
      
          new(1,(y + i)) = ceil(k*rand)*(rand>p);
          if new(1,(y + i))==3
             new(1,(y + i))=4;
          end
          
          new(end,y+line_width+1+i) = ceil(k*rand)*(rand>p);
          if new(end,y+line_width+1+i)==1
             new(end,y+line_width+1+i) =4;
          end
      end
   end
end

