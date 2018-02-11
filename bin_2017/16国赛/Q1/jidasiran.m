clc
clear
warning('off');
dirs_1=dir('Q1_data/*input.txt');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell_1=struct2cell(dirs_1)';
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames_1=dircell_1(:,1); % 第一列是文件名
dirs_2=dir('Output/修正的d/d*.txt');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell_2=struct2cell(dirs_2)';
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames_2=dircell_2(:,1); % 第一列是文件名
for m=1:length(filenames_1)
    data = textread(['Q1_data/',char(filenames_1(m))]);
    dist = textread(['Output/修正的d/',char(filenames_2(m))]);
    base_station_num = data(1,1);
    terminal_num     = data(2,1);
    dimension        = data(3,1);
    %基站坐标，【基站数*维数】
    base_station_coordinate = data(4:base_station_num+3, 1:dimension);
    %【终端数*基站数】       
        terminal_coordinate = zeros(terminal_num,3);
        xn = base_station_coordinate(base_station_num,:);
        A = zeros(base_station_num-1,3);
        b = zeros(base_station_num-1,1);
        rn = sum(xn.^2);
    for j = 1:terminal_num
        d = dist(j,:);
        for i = 1:base_station_num-1
            A(i,:) = 2*(base_station_coordinate(i,:)-xn);
            b(i) = sum(base_station_coordinate(i,:).^2) - rn - (d(i)^2 - d(base_station_num)^2);
        end
        %k = 1e4;
        %X = (A'*A+k*eye(3))\(A'*b);
        X = (A'*A)\(A'*b);
        terminal_coordinate(j,:) = X';
        disp(['位置: file = ',num2str(m),', ter_num = ', num2str(j)])
    end
    save(['Output/未修正终端坐标/','Non_output_case_',num2str(m,'%03d'),'.txt'],'terminal_coordinate','-ASCII');
end