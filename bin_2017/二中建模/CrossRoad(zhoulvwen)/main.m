% Zhou Lvwen: zhou.lv.wen@gmail.com
clear;
figure('position',[50 132 600 600],'doublebuffer','on') 
T = 1; % # hrs to simulate
line_width=4;%道宽
line_length=40;%道长
t=10;
dt=70;
allow_left = 1;%allow_left 取1表示允许左拐，取0则相反

crossroads = create_crossroads(line_width,line_length);
%====================================================
%为了显示出图形来，做了一个show_matrix                %
show_crossroads=show_matrix(crossroads,4);          %
H=image(show_crossroads);                           %
axis off                                            %
%====================================================
entry_vector = create_entry(T);
waiting_time = 0;
output = 0;
for i = 1:T*3600
    crossroads=line_move(crossroads,line_width,line_length);
    crossroads = new_cars(crossroads, entry_vector(1,i), line_length, line_width, allow_left); %allow new cars to enter
    crossroads=center_move(crossroads,line_width,line_length);
    crossroads=line_to_center(crossroads, line_length, line_width);
    [crossroads,t]=red_light(crossroads,line_width,line_length,t,dt);
    waiting_time = waiting_time + compute_wait(crossroads); %compute waiting time during timestep i
    output = output + compute_output(crossroads,line_width , line_length );
    crossroads= clear_boundary(crossroads,line_width,line_length);
    %====================================================
    show_crossroads=show_matrix(crossroads,4);           %
    set(H,'CData',show_crossroads);                      %
    pause(0.01)                                          %
    %====================================================
end
 mean_wait_time = waiting_time/sum(output) 