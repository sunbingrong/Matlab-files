nowday = [1979 01 01];
while(nowday(1)<2016)
    str1 = datenum(nowday);
    str2 = datestr(str1,'yyyymmdd');
    nowyear = datevec(str1);
    
    filename = ['...../',num2str(nowyear(1)),'/Tem_',str2,'.nc']; %前面文件名省略
    
    var = ncread(filename,'t');
    %等等操作加上就行了
    %这里加上你做的处理
    
    %屏幕显示 
    nowyear(1)
    
    str1 = str1 + 1;
    nowday = datevec(str1);
end