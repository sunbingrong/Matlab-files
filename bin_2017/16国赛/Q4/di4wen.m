%26-30的数据，第四问，3维
clear;clc
warning('off');
data = textread('竞赛用例_数据\case030_input.txt');
base_station_num = data(1,1);
terminal_num     = data(2,1);
dimension        = data(3,1);

%基站坐标，【基站数*维数】
base_station_coordinate = data(4:base_station_num+3, 1:dimension);
%【终端数*基站数】
TOA = data(base_station_num+4:base_station_num+3+terminal_num, 1:base_station_num)*3e8;

connect_num = sum(TOA'<200);%连接数
[posi1,posi2]= find(TOA'<200);%可用数据的位置
position = [posi2,posi1];j = 1;
[max_va, max_position] = max(connect_num);%最大连接数及位置
[~,posi3]= find(connect_num>3);%可获得定位的终端的位置
[~,len3] = size(posi3);
terminal_coordinate = zeros(len3,29);
terminal_final = zeros(len3,3);

%------------------------------------------------------------------------

%先利用最多连接数的终端的数据求lambda
b = find(position(:,1)==max_position);clear max_position
max_position=position(b,:);
a= zeros(1,max_va); 
for i = 1:max_va
    a(i) = TOA(max_position(1,1),max_position(i,2));
end
temp1 = floor(max_va-3); temp2 = zeros(2*temp1,4);
tic
for i = 1:temp1
    syms x y z lambda
    a1=(x-base_station_coordinate(max_position(i+3,2),1))^2 + (y-base_station_coordinate(max_position(i+3,2),2))^2 + (z-base_station_coordinate(max_position(i+3,2),3))^2 -lambda* a(1,i+3)^2;
    b1=(x-base_station_coordinate(max_position(i,2)  ,1))^2 + (y-base_station_coordinate(max_position(i,2)  ,2))^2 + (z-base_station_coordinate(max_position(i,2)  ,3))^2 -lambda* a(1,i  )^2;
    c1=(x-base_station_coordinate(max_position(i+1,2),1))^2 + (y-base_station_coordinate(max_position(i+1,2),2))^2 + (z-base_station_coordinate(max_position(i+1,2),3))^2 -lambda* a(1,i+1)^2;
    d1=(x-base_station_coordinate(max_position(i+2,2),1))^2 + (y-base_station_coordinate(max_position(i+2,2),2))^2 + (z-base_station_coordinate(max_position(i+2,2),3))^2 -lambda* a(1,i+2)^2;
    [x ,y, z,lambda]=solve(d1,b1,a1,c1,'x','y','z','lambda');
    temp2(2*i-1:2*i,:) = real(double([x  y  z lambda]));
    real(double(lambda))
end
toc
for k = 1:temp1
    terminal_coordinate(1,3*k-2:3*k) = [temp2(2*k-1,1) temp2(2*k-1,2)  temp2(2*k-1,3)];
end
lamb_final= median(temp2(:,4));
terminal_final(1,:) = [median(temp2(:,1)) median(temp2(:,2))  median(temp2(:,3))];
terminal_coordinate(1,28) = 9;
terminal_coordinate(1,29) = max_position(1,1);
%-----------------------------------------------------------------------------------------------

%只有4个基站时，代入lambda直接算
[~,posi4]= find(connect_num==4);
[~,len4] = size(posi4);
for i = 1:len4
    syms x y z lambda
    a1=(x-base_station_coordinate(4*j-2,1))^2 + (y-base_station_coordinate(4*j-2,2))^2 + (z-base_station_coordinate(4*j-2,3))^2 -lambda* TOA(posi4(i),4*j-2)^2;
    b1=(x-base_station_coordinate(4*j-1,1))^2 + (y-base_station_coordinate(4*j-1,2))^2 + (z-base_station_coordinate(4*j-1,3))^2 -lambda* TOA(posi4(i),4*j-1)^2;
    c1=(x-base_station_coordinate(4*j  ,1))^2 + (y-base_station_coordinate(4*j  ,2))^2 + (z-base_station_coordinate(4*j  ,3))^2 -lambda* TOA(posi4(i),4*j  )^2;
    d1=(x-base_station_coordinate(4*j+1,1))^2 + (y-base_station_coordinate(4*j+1,2))^2 + (z-base_station_coordinate(4*j+1,3))^2 -lambda* TOA(posi4(i),4*j+1)^2;
    [x ,y, z,lambda]=solve(d1,b1,a1,c1,'x','y','z','lambda');
    if abs(lambda(1)-lamb_final)<abs(lambda(2)-lamb_final)
        terminal_coordinate(1+i,1:3) = real(double([x(1,1) y(1,1) z(1,1)]));
    else
        terminal_coordinate(1+i,1:3) = real(double([x(2,1) y(2,1) z(2,1)]));
    end
    real(double(lambda))
    terminal_final(1+i,:) = terminal_coordinate(1+i,1:3);
    terminal_coordinate(1+i,28) = 1;
    terminal_coordinate(1+i,29) = posi4(i);
end

% --------------------------------------------------------------------------------------------------------------------

%只有5个基站时，只有5种组合，直接全部算
[~,posi5]= find(connect_num==5);
[~,len5] = size(posi5);  
syms x y z lambda
for i = 1:len5
    a1=(x-base_station_coordinate(3*j-2,1))^2 + (y-base_station_coordinate(3*j-2,2))^2 + (z-base_station_coordinate(3*j-2,3))^2 -lambda* TOA(posi5(i),3*j-2)^2;
    b1=(x-base_station_coordinate(3*j-1,1))^2 + (y-base_station_coordinate(3*j-1,2))^2 + (z-base_station_coordinate(3*j-1,3))^2 -lambda* TOA(posi5(i),3*j-1)^2;
    c1=(x-base_station_coordinate(3*j  ,1))^2 + (y-base_station_coordinate(3*j  ,2))^2 + (z-base_station_coordinate(3*j  ,3))^2 -lambda* TOA(posi5(i),3*j  )^2;
    d1=(x-base_station_coordinate(3*j+1,1))^2 + (y-base_station_coordinate(3*j+1,2))^2 + (z-base_station_coordinate(3*j+1,3))^2 -lambda* TOA(posi5(i),3*j+1)^2;
    e1=(x-base_station_coordinate(3*j+1,1))^2 + (y-base_station_coordinate(3*j+1,2))^2 + (z-base_station_coordinate(3*j+1,3))^2 -lambda* TOA(posi5(i),3*j+1)^2;
    [x1 ,y1, z1,lambda1]=solve(d1,b1,a1,c1,'x','y','z','lambda');
    [x2 ,y2, z2,lambda2]=solve(d1,b1,c1,e1,'x','y','z','lambda');
    [x3 ,y3, z3,lambda3]=solve(d1,a1,c1,e1,'x','y','z','lambda');
    [x4 ,y4, z4,lambda4]=solve(d1,b1,a1,e1,'x','y','z','lambda');
    [x5 ,y5, z5,lambda5]=solve(b1,a1,c1,e1,'x','y','z','lambda');
    
    terminal_coordinate(1+len4+i,1:3) = real(double([x1(2,1) y1(2,1) z1(2,1)]));
    terminal_coordinate(1+len4+i,4:6) = real(double([x2(2,1) y2(2,1) z2(2,1)]));
    terminal_coordinate(1+len4+i,7:9) = real(double([x3(2,1) y3(2,1) z3(2,1)]));
    terminal_coordinate(1+len4+i,10:12) = real(double([x4(2,1) y4(2,1) z4(2,1)]));
    terminal_coordinate(1+len4+i,13:15) = real(double([x5(2,1) y5(2,1) z5(2,1)]));
    terminal_final(1+len4+i,:) = [sum(terminal_coordinate(1+len4+i,[1 4 7 10 13]))/5 sum(terminal_coordinate(1+len4+i,[2 5 8 11 14]))/5  sum(terminal_coordinate(1+len4+i,[3 6 9 12 15]))/5];
    real(double(lambda1))
    real(double(lambda2))
    real(double(lambda3))
    real(double(lambda4))
    real(double(lambda5))
    terminal_coordinate(1+len4+i,28) = 5;
    terminal_coordinate(1+len4+i,29) = posi5(i);
    i
end

% ----------------------------------------------------------------------------------------------------------

%基站大于5个时，组合较多，随机选取9种组合来算
[~,posi6]= find(connect_num>5);
[~,len6] = size(posi6);
temp1 = 9; temp2 = zeros(2*temp1,4);
for j = 1:len6
    tic
    for i = 1:temp1
        syms x y z lambda
        a1=(x-base_station_coordinate(2*i-1,1))^2 + (y-base_station_coordinate(2*i-1,2))^2 + (z-base_station_coordinate(2*i-1,3))^2 -lambda* TOA(posi6(j),2*i-1)^2;
        b1=(x-base_station_coordinate(2*i  ,1))^2 + (y-base_station_coordinate(2*i  ,2))^2 + (z-base_station_coordinate(2*i  ,3))^2 -lambda* TOA(posi6(j),2*i  )^2;
        c1=(x-base_station_coordinate(2*i+1,1))^2 + (y-base_station_coordinate(2*i+1,2))^2 + (z-base_station_coordinate(2*i+1,3))^2 -lambda* TOA(posi6(j),2*i+1)^2;
        d1=(x-base_station_coordinate(2*i+2,1))^2 + (y-base_station_coordinate(2*i+2,2))^2 + (z-base_station_coordinate(2*i+2,3))^2 -lambda* TOA(posi6(j),2*i+2)^2;
        [x ,y, z,lambda]=solve(d1,b1,a1,c1,'x','y','z','lambda');
        temp2(2*i-1:2*i,:) = real(double([x  y  z lambda]));
    end
    real(double(lambda))
    for k = 1:temp1
        terminal_coordinate(1+len4+len5+j,3*k-2:3*k) = [temp2(2*k-1,1) temp2(2*k-1,2)  temp2(2*k-1,3)];
    end
    terminal_final(1+len4+len5+j,:) = [median(temp2(:,1)) median(temp2(:,2))  median(temp2(:,3))];
    j
    toc
    terminal_coordinate(1+len4+len5+j,28) = 9;
    terminal_coordinate(1+len4+len5+j,29) = posi6(j);
end

save('Output/case030/terminal_coordinate.txt','terminal_coordinate','-ASCII');
save('Output/case030/terminal_final.txt','terminal_final','-ASCII');

%计算精度
lac = zeros(len3,1);
for i = 1:len3
    lac(i) = sqrt(terminal_coordinate(i,28)/(sum(terminal_coordinate(i,1:3) - terminal_final(i,:)).^2+sum(terminal_coordinate(i,4:6) - terminal_final(i,:)).^2+sum(terminal_coordinate(i,7:9) - terminal_final(i,:)).^2));
end
save('Output/case030/lac.txt','lac','-ASCII');