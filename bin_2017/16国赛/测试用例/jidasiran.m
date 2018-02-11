clc
clear
warning('off');
dirs_1=dir('��������/*input.txt');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell_1=struct2cell(dirs_1)';
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames_1=dircell_1(:,1); % ��һ�����ļ���
dirs_2=dir('Output/������d/d*.txt');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell_2=struct2cell(dirs_2)';
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames_2=dircell_2(:,1); % ��һ�����ļ���
for m=1
    data = textread(['��������/',char(filenames_1(m))]);
    dist = textread(['Output/������d/',char(filenames_2(m))]);
    base_station_num = data(1,1);
    terminal_num     = data(2,1);
    dimension        = data(3,1);
    %��վ���꣬����վ��*ά����
    base_station_coordinate = data(4:base_station_num+3, 1:dimension);
    %���ն���*��վ����       
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
        beishu = median(abs(A(:,2)./A(:,3)));
        %max_dis=max(abs(A(:,2)./A(:,3)));
        %min_dis=min(abs(A(:,2)./A(:,3)));
        A(:,3) = 10*A(:,3);
        X = inv(A'*A)*(A'*b);
        X(3) = X(3)/10;
        terminal_coordinate(j,:) = X';
    end
    save(['Output/�ն�����/','output_case_',num2str(m+10,'%03d'),'.txt'],'terminal_coordinate','-ASCII');
end