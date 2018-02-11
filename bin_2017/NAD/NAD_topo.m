NA=binary(960:2520,1079:1879);
NA=NA';
topo_NA=zeros(161,313);
for i=1:161
    for j=1:313
        topo_NA(i,j) = NA(5*(i-1)+1,5*(j-1)+1);
    end
end

%%save xx.dat variable -ascii

