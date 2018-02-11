clc
clear
warning('off');
dirs_1=dir('Q2_data/*input.txt');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell_1=struct2cell(dirs_1)';
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames_1=dircell_1(:,1); % 第一列是文件名
dirs_2=dir('Output/修正的d/d*.txt');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell_2=struct2cell(dirs_2)';
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames_2=dircell_2(:,1); % 第一列是文件名
k_num = 20;
terminal_coordinate = zeros(k_num,3);
for m=1:length(filenames_1)
    data = textread(['Q2_data/',char(filenames_1(m))]);
    dist = textread(['Output/修正的d/',char(filenames_2(m))]);
    base_station_num = data(1,1);
    terminal_num     = data(2,1);
    dimension        = data(3,1);
    %基站坐标，【基站数*维数】
    base_station_coordinate = data(4:base_station_num+3, 1:dimension);
    
    %【终端数*基站数】
    bs_num = 10;
    A = zeros(bs_num-1,3);
    b = zeros(bs_num-1,1);
    for j = 1:terminal_num
        d = dist(j,:);
        for k = 1:k_num
            bs_index = randperm(base_station_num);
            bs_index = bs_index(1:bs_num);
            xn = base_station_coordinate(bs_index(end),:);
            rn = sum(xn.^2);
            %             for j = 1:terminal_num
            for i = 1:bs_num-1
                A(i,:) = 2*(base_station_coordinate(bs_index(i),:)-xn);
                b(i) = sum(base_station_coordinate(bs_index(i),:).^2) - rn - (d(bs_index(i))^2 - d(bs_index(end))^2);
            end
            % X = (A'*A)\(A'*b);
            kk = 1e4;
            X = (A'*A+kk*eye(3))\(A'*b);
            terminal_coordinate(k,:) = X';
            disp(['位置: file = ',num2str(m),', ter_num = ', num2str(j), ', k_num = ', num2str(k)])
        end
        save(['Output/终端坐标/10个基站/','output_case_',num2str(m+10,'%03d'),'_t', num2str(j,'%04d'), ...
            '.txt'],'terminal_coordinate','-ASCII');
    end
end