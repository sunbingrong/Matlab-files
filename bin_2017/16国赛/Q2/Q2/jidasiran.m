clc
clear
warning('off');
dirs_1=dir('Q2_data/*input.txt');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell_1=struct2cell(dirs_1)';
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames_1=dircell_1(:,1); % ��һ�����ļ���
dirs_2=dir('Output/������d/d*.txt');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell_2=struct2cell(dirs_2)';
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames_2=dircell_2(:,1); % ��һ�����ļ���
k_num = 20;
terminal_coordinate = zeros(k_num,3);
for m=1:length(filenames_1)
    data = textread(['Q2_data/',char(filenames_1(m))]);
    dist = textread(['Output/������d/',char(filenames_2(m))]);
    base_station_num = data(1,1);
    terminal_num     = data(2,1);
    dimension        = data(3,1);
    %��վ���꣬����վ��*ά����
    base_station_coordinate = data(4:base_station_num+3, 1:dimension);
    
    %���ն���*��վ����
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
            disp(['λ��: file = ',num2str(m),', ter_num = ', num2str(j), ', k_num = ', num2str(k)])
        end
        save(['Output/�ն�����/10����վ/','output_case_',num2str(m+10,'%03d'),'_t', num2str(j,'%04d'), ...
            '.txt'],'terminal_coordinate','-ASCII');
    end
end