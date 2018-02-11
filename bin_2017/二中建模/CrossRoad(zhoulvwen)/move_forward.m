function new = move_forward(old)
new = old; %create new traffic circle looking same as old
[L, W] = size(new); %get its dimensions
prob = .7;

for i = (L-1):-1:1
    for j = 1:W
        if new(i,j) >=1
           if new(i+1, j) ~= 0
              new(i,j) = -new(i,j);
           end
          if new(i+1, j) == 0
             if prob >= rand
                new(i+1, j) = new(i,j);
                new(i,j) = 0;
             end
          end
       end
    end
end
