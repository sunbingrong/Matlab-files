new_modeltopo_IP=zeros(151,521);
modeltopo_IP=[binary(540:1440,2520:4320) binary(540:1440,2:1321)];
for i=1:151
    for j=1:521
        new_modeltopo_IP(i,j)=modeltopo_IP(6*(i-1)+1,6*(j-1)+1);
    end
end
new_modeltopo_IP=new_modeltopo_IP';
