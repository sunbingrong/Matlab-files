for y=1:year_days
        %../是往外推一层.
        filename2=['/Users/luobinhe/Documents/mat_interm/air/',str,'/tem_',str2,'.mat'];
        var_daily_mean=cell2mat(struct2cell(load(filename2)));
        %此处出现问题,就是y/1:year_days!
        var_daily_mean1(:,:,1:year_days)=var_daily_mean(:,:,22);
        
        date_now=str2num(str2);
        date_now=date_now+1;
        
        dataz=cat(3,dataz,var_daily_mean1); 
end