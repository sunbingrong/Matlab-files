%测试路径耗损模型,用损耗反推距离
clc
clear
warning('off');
dirs=dir('测试用例/*input.txt');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)';
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1); % 第一列是文件名
a = textread('Output/初估lamda/a_case_001.txt');
for m=1
data = textread(['测试用例/',char(filenames(m))]);
base_station_num = data(1,1);
terminal_num     = data(2,1);
dimension        = data(3,1);
%基站坐标，【基站数*维数】
base_station_coordinate = data(4:base_station_num+3, 1:dimension);
%【终端数*基站数】
TOA = data(base_station_num+4:base_station_num+3+terminal_num, 1:base_station_num)*3e8;
d = TOA;
eps = 5;
f = 880; hte = base_station_coordinate(:,3); hre = 1.48; Lp0 = 69.555; n1 = 1;n2 = 20;
% 对于中小城市而言
%a_hre = (1.1*log10(f)-0.7)*hre-(1.56*log10(f)-0.8);
% 对于大城市而言
a_hre = 3.2*(log10(11.75*hre))^2-4.97;
A = 69.555+26.16*log10(f)-13.82*log10(hte)-a_hre;
B = 44.9-6.55*log10(hre);
tic;
lamda = a(m);
for i = 1:terminal_num
    for j = 1:base_station_num
           n1 = 1;  n2 = 20;
           Lp(i,j) = A(j,1) + B.*log10(d(i,j));
           d_simulate1(i,j) = 10^((Lp(i,j) - Lp0)/(10*n1));
           d_simulate2(i,j) = 10^((Lp(i,j) - Lp0)/(10*n2));
           s = sign(d_simulate1(i,j) - sqrt(lamda)*d(i,j));
           t = sign(d_simulate2(i,j) - sqrt(lamda)*d(i,j));
           x = (n1 + n2)/2;
           d_simulate(i,j) = 10^((Lp(i,j) - Lp0)/(10*x));
           while (abs(d_simulate(i,j) - sqrt(lamda)*d(i,j)) > eps)
              d_simulate(i,j) = 10^((Lp(i,j) - Lp0)/(10*x));
              if sign(d_simulate(i,j) - sqrt(lamda)*d(i,j)) == s
                 n1 = x;
              else
                 n2 = x;
              end
              x = (n1 + n2)/2;
           end
           j
    end
end
save(['Output/修正的d/','d_output_case_',num2str(m+10,'%03d'),'.txt'],'d_simulate','-ASCII');
end
toc;