%��һ�ʣ�3ά
clc
clear
warning('off');
dirs=dir('Q2_data/*input.txt');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)'; 
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
for t=1:length(filenames)
    data = textread(['Q2_data/',char(filenames(t))]);
    base_station_num = data(1,1);
    terminal_num     = data(2,1);
    dimension        = data(3,1);
%��վ���꣬����վ��*ά����
base_station_coordinate = data(4:base_station_num+3, 1:dimension);
%���ն���*��վ����
TOA = data(base_station_num+4:base_station_num+3+terminal_num, 1:base_station_num)*3e8;
tic;
bs_num = 4;
terminal_coordinate = zeros(terminal_num,3);
for j = 1:20
        bs_index = randperm(base_station_num);
        bs_index = bs_index(1:bs_num);
        syms x y z lambda
        a1=(x-base_station_coordinate(bs_index(1),1))^2 + (y-base_station_coordinate(bs_index(1),2))^2 + (z-base_station_coordinate(bs_index(1),3))^2 -lambda* TOA(j,bs_index(1))^2;
        b1=(x-base_station_coordinate(bs_index(2),1))^2 + (y-base_station_coordinate(bs_index(2),2))^2 + (z-base_station_coordinate(bs_index(2),3))^2 -lambda* TOA(j,bs_index(2))^2;
        c1=(x-base_station_coordinate(bs_index(3),1))^2 + (y-base_station_coordinate(bs_index(3),2))^2 + (z-base_station_coordinate(bs_index(3),3))^2 -lambda* TOA(j,bs_index(3))^2;
        d1=(x-base_station_coordinate(bs_index(4),1))^2 + (y-base_station_coordinate(bs_index(4),2))^2 + (z-base_station_coordinate(bs_index(4),3))^2 -lambda* TOA(j,bs_index(4))^2;
        [x ,y, z,lambda]=solve(d1,b1,a1,c1,'x','y','z','lambda');
        temp2 = real(double([x  y  z lambda]));
        terminal_coordinate(j,:) = [median(temp2(1,1)) median(temp2(1,2)) median(temp2(1,3))];
        lamb(t) = median(temp2(1,4));
    j
end
a(t) = lamb(t);
end
save('Output/����lamda/lamda.txt','a','-ASCII');
toc;