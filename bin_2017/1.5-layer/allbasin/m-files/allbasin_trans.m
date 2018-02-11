clear;clc;
load('modeltopo_quar_NP_200m_isobath.dat');
basic_topo = reshape(modeltopo_quar_NP_200m_isobath,[761 221]);
for EB = 280
    nx = 4*(EB-100)+1;
    ny = 221;
    topo = basic_topo(1:nx,:);
end
k = 0;
for EB = 280
    k = k + 1;
    y = 18; %18N
    delta_x = 6.371e6*cos(y*pi/180)*(0.25*pi/180);
    load(['../Output/allbasin_trans_',num2str(EB),'E_h.mat']);
    H = h_trans + 350;
    load(['../Output/allbasin_trans_',num2str(EB),'E_v.mat']);
    v = v_trans;
    a1=reshape(H,[33,17,360,10]); a2=reshape(v,[33,17,360,10]); %16N-18N 122E-130E
    b1=mean(a1,4); b2=mean(a2,4);
    c1=reshape(b1,[33,17,30,12]); c2=reshape(b2,[33,17,30,12]);
    H_trans = reshape(mean(reshape(mean(c1,3),[33,17,12]),2),[33,12]);
    V_trans = reshape(mean(reshape(mean(c2,3),[33,17,12]),2),[33,12]);
    for i = 1:12
        trans(k,i) = V_trans(:,i)'*H_trans(:,i)*delta_x;
    end
    plot(trans(k,:))
    xlim([1 12])
    hold on
end