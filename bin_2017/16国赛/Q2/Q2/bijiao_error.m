clc
clear
warning('off');
dirs_1=dir('Output/���/10����վ/output*.txt');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell_1=struct2cell(dirs_1)';
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames_1=dircell_1(:,1); % ��һ�����ļ���
RMSE = zeros(length(filenames_1),1);
for m=1:length(filenames_1)
    error = textread(['Output/���/10����վ/',char(filenames_1(m))]);
    [terminal_num,~] = size(error);
    RMSE(m,1)  = sum(error(:,3))/terminal_num;
end
save(['Output/���/10����վ/','RMSE_output.txt'],'RMSE','-ASCII');