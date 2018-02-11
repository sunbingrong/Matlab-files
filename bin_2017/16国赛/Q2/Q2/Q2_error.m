clc
clear
warning('off');
for t = 1:10
    dirs_1=dir(['Output/�ն�����/10����վ/output_case_',num2str(t+10,'%03d'),'_t*.txt']);
    % ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
    dircell_1=struct2cell(dirs_1)';
    % �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
    filenames_1=dircell_1(:,1); % ��һ�����ļ���
%     dirs_2=dir('Output/������d/d*.txt');
%     % ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
%     dircell_2=struct2cell(dirs_2)';
%     % �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
%     filenames_2=dircell_2(:,1); % ��һ�����ļ���
%     k_num = 20;
%     terminal_coordinate = zeros(k_num,3);
    n = length(filenames_1);
    terminal_coordinate_mean_err = zeros(n,3);
    for m=1:n
        terminal_coordinate = textread(['Output/�ն�����/10����վ/',char(filenames_1(m))]);
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
    save(['Output/���/10����վ/','output_case_',num2str(t+10,'%03d'),  ...
                'err.txt'],'terminal_coordinate_mean_err','-ASCII');
end