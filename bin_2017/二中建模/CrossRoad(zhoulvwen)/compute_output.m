function count = compute_output(crossroads,line_width , line_length )
count = [0 0 0 0];
for j = line_length+1:line_length+line_width;
count(1) = count(1)+(crossroads(j,1)>0);
count(2) = count(2)+(crossroads(j+line_width+1,end)>0);
count(3) = count(3)+(crossroads(1,j+line_width+1)>0);
count(4) = count(4)+(crossroads(end,j)>0);
end

