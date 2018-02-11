function crossroads=center_move(crossroads,line_width,line_length)
c=line_length-line_width;
center=crossroads(c:end-c+1,c:end-c+1);
center([1,end],:)=-88;
center(:,[1,end])=-88;

px=zeros(length(center),1);
py=px;
px(1:line_width+1)=1;
px(2+line_width:1+2*line_width)=0;
px(2+2*line_width:end)=-1;

py(1:line_width+1)=0;
py(2+line_width:1+2*line_width)=1;
py(2+2*line_width:end)=0;

center=center_move_forward(center,px,py);

crossroads(c+1:end-c,c+1:end-c)=center(2:end-1,2:end-1);