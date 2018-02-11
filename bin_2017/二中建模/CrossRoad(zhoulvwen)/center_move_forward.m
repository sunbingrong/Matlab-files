function new = center_move_forward(old,px,py)
new = old; %create new traffic circle looking same as old
[L, W] = size(new); %get its dimensions
prob = .7;
pd=0.45;
for k=1:4
for i = (L-1):-1:1
    for j = 1:W
        p=rand;
        if pd >= p
            y=py(j);x=px(j);
            py(j)=1;px(j)=0;
        end
        if new(i,j) ==k
           if new(i+py(j), j+px(j)) ~= 0
              new(i,j) = -new(i,j);
           end
           if new(i+py(j), j+px(j)) == 0
              if prob >= rand
                 new(i+py(j), j+px(j)) = new(i,j);
                 new(i,j) = 0; 
              end
           end
        end
        if pd >= p
           py(j)=y;px(j)=x;
        end
    end
end
new=switch_lanes(new,0.7);
new=rot90(new);
end