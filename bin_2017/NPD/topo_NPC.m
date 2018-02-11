topo_NPC=zeros(241,721);
for i=1:241
    for j=1:721
        topo_NPC(i,j) = NPC(2*(i-1)+1,2*(j-1)+1);
    end
end
