% 平均位置
clc
clear
dirs=dir('D:/Applications/Matlab2015b/bin/bin文件/bin（2015）/1.5-layer/局域海盆边界_各实验分叉点/*.dat');
% 用你需要的目录以及文件扩展名替换。读取某个目录的指定类型文件列表，返回结构数组。
dircell=struct2cell(dirs)' ;   
% 结构体(struct)转换成元胞类型(cell)，转置一下是让文件名按列排列。
filenames=dircell(:,1) ; % 第一列是文件名
%读取流速数据
%保存文件vel.mat;

for t=1:length(filenames)
    a=char(filenames(t));
    fid = load(a);
    bifur = fid(3601:end,2);
    a=reshape(bifur,[30,12,10]);
    b=sum(a,3)/10;
    c=sum(b)/30;
    d(t)=sum(c)/12;
    if (t == 1) basic = d(t);
    end
end
    x=1:13;
    plot(x,d,'-bo','LineWidth',1.5)
    xlim([1,13])
    hold on
    ylabel('Latitude(°N)');
    title('The Mean Latitude of Bifurcation of NEC')
    y=basic*ones(13,1);
    plot(x,y,'-r','LineWidth',1.5);
    set(gca,'XTick',1:13);
    set(gca,'XTickLabel',{'Control','140E','150E','160E','170E','180W','170W','160W','150W','140W','130W','120W','110W'});