year_month_day = [1979 01 01];
date_num = datenum(year_month_day);
date_str = datestr(date_num,'yyyymmdd');
for y=1:2
        %../是往外推一层.
        filename = ['tem_',date_str,'.mat'];
        var_daily_mean = cell2mat(struct2cell(load(filename)));
        %此处出现问题,就是y/1:year_days!
        var_daily_mean1(:,:,y) = var_daily_mean(:,:,22);
        
        date_num = date_num + 1;
        date_str = datestr(date_num,'yyyymmdd');
        
     %   dataz=cat(3,dataz,var_daily_mean1); 
end
%%
year_month_day_1 = [1993 01 01];
date_num_1 = datenum(year_month_day_1);
year_month_day_0 = [1948 01 01];
date_num_0 = datenum(year_month_day_0);
cha_num = date_num_1 - date_num_0