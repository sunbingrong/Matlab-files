function new = clear_boundary( old , line_width , line_length )
new=old;
a=line_length+1:line_length+line_width;
new(a,1) = 0;
new(a+line_width+1,end)=0;
new(1,a+line_width+1) = 0;
new(end,a)=0;
