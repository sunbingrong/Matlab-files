function new = switch_lanes(old,prob)
new = old;
%prob = 0.7;
[L,W] = size(new);
for i = (L-1):-1:1
   for j = 2:(W-1)
       x = rand;
       y = rand;
       if new(i,j)>-88&new(i,j)<0
          if x < prob %chance turn will be made
             if y > 0.5 %will attempt left
                if new(i, j-1) == 0
                   new(i, j-1) = -new(i,j);
                   new(i, j) = 0;
                elseif new(i, j+1) == 0
                   new(i, j+1) = -new(i,j);
                   new(i,j) = 0;
                elseif new(i,j)>-88&new(i,j)<0
                   new(i,j) = -new(i,j);
                end
              end
              if y <= 0.5 %will attempt right
                 if new(i, j+1) == 0
                    new(i,j+1) = -new(i,j);
                    new(i,j) = 0;
                 elseif new(i, j-1) == 0
                    new(i, j-1) = -new(i,j);
                    new(i,j) = 0;
                 elseif new(i,j)>-88&new(i,j)<0
                    new(i,j) = -new(i,j);
              end
            end
          end
          if x >= prob
             new(i,j) = -new(i,j);
          end
        end
      end
end