
%% �޳���Ч��
lat=121;
lon=360;

count1=zeros(lat,lon);
count1=isnan(APT_4(:,:));%��ά��ȥ��ʱ��ѭ��

%�޳���Ч��
count2=zeros(lat,lon,1680);
for i=1:1680
    count2=count2+isnan(squeeze(tosin(:,:,i)));
end



count=count1+count2;


%���ռ�ά�Ƚ�ά��ȥ��nan��
i=1;
    for ix=1:lat
        for iy=1:lon
            if count(ix,iy)==0 
                Y(i,:)= tosin(ix,iy,:);
                i=i+1;
            end
        end
    end

%���ռ�ά�Ƚ�ά��ȥ��nan�㣬����ά
i=1;
    for ix=1:lat
        for iy=1:lon
            if count(ix,iy)==0 
                X(i)= APT_4(ix,iy);
                i=i+1;
            end
        end
    end
