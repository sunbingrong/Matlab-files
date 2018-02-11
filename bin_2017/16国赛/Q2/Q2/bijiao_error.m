clc
clear
warning('off');
dirs_1=dir('Output/误差/10个基站/output*.txt');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell_1=struct2cell(dirs_1)';
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames_1=dircell_1(:,1); % 第一列是文件名
RMSE = zeros(length(filenames_1),1);
for m=1:length(filenames_1)
    error = textread(['Output/误差/10个基站/',char(filenames_1(m))]);
    [terminal_num,~] = size(error);
    RMSE(m,1)  = sum(error(:,3))/terminal_num;
end
save(['Output/误差/10个基站/','RMSE_output.txt'],'RMSE','-ASCII');