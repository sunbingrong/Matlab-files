clear;clc;
load('modeltopo_quar_NP_200m_isobath.dat');
basic_topo = reshape(modeltopo_quar_NP_200m_isobath,[761 221]);
for EB = 280
    nx = 4*(EB-100)+1;
    ny = 221;
    topo = basic_topo(1:nx,:);
end
k = 0;
for EB = 180
    k = k + 1;
    y = 18; %18N
    delta_x = 6.371e6*cos(y*pi/180)*(0.25*pi/180);
    load(['../Output/trans_',num2str(EB),'E_h.mat']);
    H = h_trans(:,14,end-359:end) + 400;
    load(['../Output/trans_',num2str(EB),'E_v.mat']);
    v = v_trans(:,14,end-359:end);
    %16N-20N Æ½¾ù
%     a1=reshape(H,[33,17,30,12]); a2=reshape(v,[33,17,30,12]); %122E-130E 16N-20N
%     b1=reshape(mean(a1,2),[33,30,12]);b2=reshape(mean(a2,2),[33,30,12]);
%     H_trans = reshape(mean(b1,2),[33,12]);
%     V_trans = reshape(mean(b2,2),[33,12]);
    
    a1=reshape(H,[33,30,12]); a2=reshape(v,[33,30,12]); %122E-130E 16N-20N
    H_trans = reshape(mean(a1,2),[33,12]);
    V_trans = reshape(mean(a2,2),[33,12]);
    for i = 1:12
        trans(k,i) = V_trans(:,i)'*H_trans(:,i)*delta_x;
    end
    plot(trans(k,:))
    xlim([1 12])
    hold on
end
%%
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
    load(['../Output/trans_',num2str(EB),'E_h.mat']);
    H = h_trans(:,:,end-359:end)+350;
    %H(H==350)=0;
    load(['../Output/trans_',num2str(EB),'E_v.mat']);
    v = v_trans(:,:,end-359:end);
    a1=reshape(H,[33,17,30,12]); a2=reshape(v,[33,17,30,12]); %122E-130E 16N-20N
    b1 = reshape(mean(a1,2),[33,30,12]);
    b2 = reshape(mean(a2,2),[33,30,12]);
    H_trans = reshape(mean(b1,2),[33,12]);
    V_trans = reshape(mean(b2,2),[33,12]);
    for i = 1:12
        trans(k,i) = V_trans(:,i)'*H_trans(:,i)*delta_x/10^6;
    end
    plot(trans(k,:))
    xlim([1 12])
    hold on
end