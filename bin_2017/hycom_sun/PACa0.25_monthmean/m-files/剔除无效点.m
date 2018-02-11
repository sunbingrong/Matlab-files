
%% 剔除无效点
lat=121;
lon=360;

count1=zeros(lat,lon);
count1=isnan(APT_4(:,:));%二维，去掉时间循环

%剔除无效点
count2=zeros(lat,lon,1680);
for i=1:1680
    count2=count2+isnan(squeeze(tosin(:,:,i)));
end



count=count1+count2;


%将空间维度降维，去除nan点
i=1;
    for ix=1:lat
        for iy=1:lon
            if count(ix,iy)==0 
                Y(i,:)= tosin(ix,iy,:);
                i=i+1;
            end
        end
    end

%将空间维度降维，去除nan点，并降维
i=1;
    for ix=1:lat
        for iy=1:lon
            if count(ix,iy)==0 
                X(i)= APT_4(ix,iy);
                i=i+1;
            end
        end
    end
