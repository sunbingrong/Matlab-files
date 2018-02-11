function crossroads=line_move(crossroads,line_width,line_length)
c=line_length-line_width;
line_u=crossroads(1:c,line_length:end-line_length+1);

line_d=crossroads(end-c+1:end,line_length:end-line_length+1);

line_l=crossroads(line_length:end-line_length+1,1:c);
line_l=rot90(line_l);

line_r=crossroads(line_length:end-line_length+1,end-c+1:end);
line_r=rot90(line_r);
[r1,r2]=size(line_r);
LINE(:,:,1)=[-88*ones(r1+2,1) [-88*ones(1,r2);line_u;-88*ones(1,r2)] -88*ones(r1+2,1)];
LINE(:,:,2)=[-88*ones(r1+2,1) [-88*ones(1,r2);line_d;-88*ones(1,r2)] -88*ones(r1+2,1)];
LINE(:,:,3)=[-88*ones(r1+2,1) [-88*ones(1,r2);line_l;-88*ones(1,r2)] -88*ones(r1+2,1)];
LINE(:,:,4)=[-88*ones(r1+2,1) [-88*ones(1,r2);line_r;-88*ones(1,r2)] -88*ones(r1+2,1)];
for i=1:4
    LINE(:,end-line_width-1:end,i)=flipud(LINE(:,end-line_width-1:end,i));
    LINE(:,:,i)=move_forward(LINE(:,:,i));
    LINE(:,:,i)=switch_lanes(LINE(:,:,i),0.7);
    LINE(:,end-line_width-1:end,i)=flipud(LINE(:,end-line_width-1:end,i));
end
LINE([1,end],:,:)=[];
LINE(:,[1,end],:)=[];
line_u=LINE(:,:,1);
line_d=LINE(:,:,2);
line_l=rot90(rot90(rot90(LINE(:,:,3))));
line_r=rot90(rot90(rot90(LINE(:,:,4))));

crossroads(1:c,line_length:end-line_length+1)=line_u;
crossroads(end-c+1:end,line_length:end-line_length+1)=line_d;
crossroads(line_length:end-line_length+1,1:c)=line_l;
crossroads(line_length:end-line_length+1,end-c+1:end)=line_r;