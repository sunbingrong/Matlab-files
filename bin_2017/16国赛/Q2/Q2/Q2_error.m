clc
clear
warning('off');
for t = 1:10
    dirs_1=dir(['Output/终端坐标/10个基站/output_case_',num2str(t+10,'%03d'),'_t*.txt']);
    % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
    dircell_1=struct2cell(dirs_1)';
    % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
    filenames_1=dircell_1(:,1); % 第一列是文件名
%     dirs_2=dir('Output/修正的d/d*.txt');
%     % 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
%     dircell_2=struct2cell(dirs_2)';
%     % 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
%     filenames_2=dircell_2(:,1); % 第一列是文件名
%     k_num = 20;
%     terminal_coordinate = zeros(k_num,3);
    n = length(filenames_1);
    terminal_coordinate_mean_err = zeros(n,3);
    for m=1:n
        terminal_coordinate = textread(['Output/终端坐标/10个基站/',char(filenames_1(m))]);
        mm = size(terminal_coordinate,1);
        terminal_coordinate_mean = mean(terminal_coordinate);
        terminal_coordinate_sum  = 0;
        for i = 1:mm
            terminal_coordinate_sum = terminal_coordinate_sum + sum((terminal_coordinate(i,1:2)-terminal_coordinate_mean(1:2)).^2);
        end
        terminal_coordinate_std = sqrt(1/mm*terminal_coordinate_sum);
        terminal_coordinate_mean_err(m,:) = [terminal_coordinate_mean(1:2),terminal_coordinate_std];
    end
    disp(['RMSE : file = ',num2str(t),', ter_num = ', num2str(m)])
    save(['Output/误差/10个基站/','output_case_',num2str(t+10,'%03d'),  ...
                'err.txt'],'terminal_coordinate_mean_err','-ASCII');
end