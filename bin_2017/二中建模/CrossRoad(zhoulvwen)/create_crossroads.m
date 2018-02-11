function crossroads = create_crossroads(line_width,line_length)
h=line_length+line_width;
c=line_length-line_width;
r=2*h+1;
crossroads=zeros(r);
crossroads([1:c r-c+1:r],h+1)=-88;
crossroads(h+1,[1:c r-c+1:r])=-88;
for i=1:line_length
    for j=1:line_length
        if (i+j)<(c+line_length+2)
            crossroads(i,j)=-88;
            crossroads(r-i+1,r-j+1)=-88;
            crossroads(r-i+1,j)=-88;
            crossroads(i,r-j+1)=-88;
        end
    end
end

