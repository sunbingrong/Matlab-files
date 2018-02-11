clear;
clc;
load model_topo.mat
for EB = 140:10:290
    topo = model_topo(1:(EB-100)*4+1,:);
    topo(end,:) = 0;
    save(['/home/user/sbr/sbr/box_Vorticity/Input/topo_',num2str(EB),'E.mat'],'topo');
end
    
