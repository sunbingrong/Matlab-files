%��һ�ʣ�3ά
clc
clear
warning('off');
dirs=dir('��������/*input.txt');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)';  
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
for t=1:length(filenames)
    data = textread(['��������/',char(filenames(t))]);
    base_station_num = data(1,1);
    terminal_num     = data(2,1);
    dimension        = data(3,1);
%��վ���꣬����վ��*ά����
base_station_coordinate = data(4:base_station_num+3, 1:dimension);
%���ն���*��վ����
TOA = data(base_station_num+4:base_station_num+3+terminal_num, 1:base_station_num)*3e8;
tic;
temp1 = floor((base_station_num-1)/3); temp2 = zeros(2*temp1,4);
terminal_coordinate = zeros(terminal_num,3);
for j = 1:20
    for i = 1:temp1
        syms x y z lambda
        a1=(x-base_station_coordinate(3*i-2,1))^2 + (y-base_station_coordinate(3*i-2,2))^2 + (z-base_station_coordinate(3*i-2,3))^2 - lambda* TOA(j,3*i-2)^2 ;
        b1=(x-base_station_coordinate(3*i-1,1))^2 + (y-base_station_coordinate(3*i-1,2))^2 + (z-base_station_coordinate(3*i-1,3))^2 - lambda* TOA(j,3*i-1)^2 ;
        c1=(x-base_station_coordinate(3*i  ,1))^2 + (y-base_station_coordinate(3*i  ,2))^2 + (z-base_station_coordinate(3*i  ,3))^2 - lambda* TOA(j,3*i  )^2 ;
        d1=(x-base_station_coordinate(3*i+1,1))^2 + (y-base_station_coordinate(3*i+1,2))^2 + (z-base_station_coordinate(3*i+1,3))^2 - lambda* TOA(j,3*i+1)^2 ;
        [x ,y, z,lambda]=solve(d1,b1,a1,c1,'x','y','z','lambda');
        temp2(2*i-1:2*i,:) = real(double([x  y  z lambda]));
    end
    terminal_coordinate(j,:) = [median(temp2(:,1)) median(temp2(:,2)) median(temp2(:,3))];
    lamb = median(temp2(:,4));
    j
end
a(t) = lamb(t);
save(['Output/','a_case_',num2str(t,'%03d'),'.txt'],'a','-ASCII');
end
toc;