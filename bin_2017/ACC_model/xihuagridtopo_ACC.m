danyuan=zeros(1,9);
new_modeltopo_ACC=zeros(72,960);
for j=1:2:959
    for i=1:2:71
        new_modeltopo_ACC(i,j)=modeltopo_ACC(9*((i-1)/2)+1,9*((j-1)/2)+1);
    end
end
for j=1:2:959
    for i=2:2:72
        t=(modeltopo_ACC(9*i/2-4,9*((j-1)/2)+1)+modeltopo_ACC(9*i/2-3,9*((j-1)/2)+1))/2;
        new_modeltopo_ACC(i,j)=fix(t);
    end
end
for j=2:2:960
    for i=1:2:71
        t=(modeltopo_ACC(9*(i-1)/2+1,9*j/2-4)+modeltopo_ACC(9*(i-1)/2+1,9*j/2-3))/2;
        new_modeltopo_ACC(i,j)=fix(t);
    end
end
for j=2:2:960
    for i=2:2:72
        t=(modeltopo_ACC(9*i/2-4,9*j/2-4)+modeltopo_ACC(9*i/2-4,9*j/2-3))/2;
        new_modeltopo_ACC(i,j)=fix(t);
    end
end