    function dt = Time_Step ( Q, Problem )
        if Problem == 0, dt = CFL*dx          ; end
        if Problem == 1, dt = CFL*dx/(max(abs(Q(:,1)))) ; end
        if Problem == 2
            h = zeros(length(x)-1,length(y)-1);
            for h_i = 1:length(x)-1
                for h_j = 1:length(y)-1
                    h(h_i,h_j)      =  abs(a/dx(h_i))+abs(b/dy(h_j));
                end
            end
            dt = CFL/max(max(h)) ; 
        end
    end
    
    