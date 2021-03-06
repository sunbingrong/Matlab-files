load('modeltopo_quar_NP_200m_isobath.dat');
basic_topo = reshape(modeltopo_quar_NP_200m_isobath,[761 221]);
for EB = 180
    nx = 4*(EB-100)+1;
    ny = 221;
    topo = basic_topo(1:nx,:);
    topo = reshape(topo,[nx*ny 1]);
    %save(['case',num2str(EB),'E_topo.dat'],'topo','-ascii');
end


contourf(v(:,:,1)')
v(v==0)=nan;
hold on
contour(basic_topo')