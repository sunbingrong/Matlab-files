nowday = [1979 01 01];
while(nowday(1)<2016)
    str1 = datenum(nowday);
    str2 = datestr(str1,'yyyymmdd');
    nowyear = datevec(str1);
    
    filename = ['...../',num2str(nowyear(1)),'/Tem_',str2,'.nc']; %ǰ���ļ���ʡ��
    
    var = ncread(filename,'t');
    %�ȵȲ������Ͼ�����
    %������������Ĵ���
    
    %��Ļ��ʾ 
    nowyear(1)
    
    str1 = str1 + 1;
    nowday = datevec(str1);
end