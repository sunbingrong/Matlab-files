clear;clc
for EB = 250
    load(['../Output/H_',num2str(EB),'E.mat']);
    [nx,ny,nt]=size(H_NP);
    multiple = zeros(nx,ny,nt-1);
    for j = 1:ny
        for t = 1:nt-1
            for i = 1:nx
                if (H_NP(i,j,t) == NaN)
                    multiple(i,j,t) = 0;
                else
                    multiple(i,j,t) = H_NP(i,j,t+1)./H_NP(i,j,t);
                end
            end
        end
    end
end