for y=1:year_days
        %../��������һ��.
        filename2=['/Users/luobinhe/Documents/mat_interm/air/',str,'/tem_',str2,'.mat'];
        var_daily_mean=cell2mat(struct2cell(load(filename2)));
        %�˴���������,����y/1:year_days!
        var_daily_mean1(:,:,1:year_days)=var_daily_mean(:,:,22);
        
        date_now=str2num(str2);
        date_now=date_now+1;
        
        dataz=cat(3,dataz,var_daily_mean1); 
end