% 18N 源地黑潮的流量 Kuroshio
% 源数据为 120E - 140E  0N - 30N
clear;clc;
figure
k = 0;
for EB = 290
    k = k + 1;
    y = 18; %18N
    delta_x = 6.371e6*cos(y*pi/180)*(0.25*pi/180);
    load(['../Input/OBC_trans_',num2str(EB),'E_h.mat']);
    H = h_trans(9:41,73,end-359:end) + 350;        % 122E - 130E  18N
    load(['../Input/OBC_trans_',num2str(EB),'E_v.mat']);
    v = v_trans(9:41,73,end-359:end);
    %16N-20N 平均
    %     a1=reshape(H,[33,17,30,12]); a2=reshape(v,[33,17,30,12]); %122E-130E 16N-20N
    %     b1=reshape(mean(a1,2),[33,30,12]);b2=reshape(mean(a2,2),[33,30,12]);
    %     H_trans = reshape(mean(b1,2),[33,12]);
    %     V_trans = reshape(mean(b2,2),[33,12]);
    
    a1=reshape(H,[33,30,12]); %122E-130E 16N-20N
    a2=reshape(v,[33,30,12]);
    H_trans = reshape(mean(a1,2),[33,12]);
    V_trans = reshape(mean(a2,2),[33,12]);
    for i = 1:12
         trans(k,i) = V_trans(:,i)'*H_trans(:,i)*delta_x/10^6;
    end
    trans_min = min(trans(k,:));
    trans_max= max(trans(k,:));
    subplot(4,4,k);
    plot(trans(k,:),'-b','LineWidth',3.5)
    hold on
    plot(trans(k,:),'o','MarkerSize',10,'MarkerFaceColor','b')
    xlim([0.5 12.5])
    ylim([floor(trans_min) ceil(trans_max)])
    set(gca,'XTick',1:12)
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    %set(gca,'YTick',floor(trans_min):ceil(trans_max))
    p1 = get(gca,'position');
    xlabel('Month');
    if mod(k,4) == 1
        ylabel('Sv')
        set(gca,'position',p1);
    else
        if mod(k,4) == 0
            p1(1) = p1(1) - 0.03*3;
            set(gca,'position',p1);
        else
            p1(1) = p1(1) - 0.03*(mod(k,4)-1);
            set(gca,'position',p1);
        end
    end
    p1(2) = p1(2) - 0.016*ceil(k/4-1);
    set(gca,'position',p1);
    if EB == 290
        title('Control Run KC Transport');
    else
        title(['Seasonal KC Transport  EB\_', num2str(EB),'E'])
    end
    %title('Seasonal Transport in Source Region of Kuroshio')
    set(gca,'fontsize',12)
    disp(['Processing : ',num2str(EB),'E'])
    clear h_trans v_trans
end
Trans_Sen = trans(1:end-1,:);
Trans_Ctrl = trans(end,:);
%save('../Output/18N_Trans_Ctrl.mat','Trans_Ctrl');
%save('../Output/18N_Trans_Sen.mat','Trans_Sen');
%% 8N 棉兰老流的流量 Mindanao Current
% 源数据为 120E - 140E  0N - 30N
figure
clear;clc;
k = 0;
for EB = 290
    k = k + 1;
    y = 8;  %8N
    delta_x = 6.371e6*cos(y*pi/180)*(0.25*pi/180);
    load(['../Input/OBC_trans_',num2str(EB),'E_h.mat']);
    H = h_trans(25:41,33,end-359:end) + 350;        % 126.25E - 129E  8N
    load(['../Input/OBC_trans_',num2str(EB),'E_v.mat']);
    v = v_trans(25:41,33,end-359:end);
    %16N-20N 平均
    %     a1=reshape(H,[33,17,30,12]); a2=reshape(v,[33,17,30,12]); %122E-130E 16N-20N
    %     b1=reshape(mean(a1,2),[33,30,12]);b2=reshape(mean(a2,2),[33,30,12]);
    %     H_trans = reshape(mean(b1,2),[33,12]);
    %     V_trans = reshape(mean(b2,2),[33,12]);
    
    a1=reshape(H,[17,30,12]); %122E-130E 16N-20N
    a2=reshape(v,[17,30,12]);
    H_trans = reshape(mean(a1,2),[17,12]);
    V_trans = reshape(mean(a2,2),[17,12]);
    for i = 1:12
        trans(k,i) = -V_trans(:,i)'*H_trans(:,i)*delta_x/10^6;
    end
    trans_min = min(trans(k,:));
    trans_max= max(trans(k,:));
    subplot(4,4,k);
    %trans(k,:) = smooth(trans(k,:));
    plot(trans(k,:),'-b','LineWidth',3.5)
    hold on
    plot(trans(k,:),'o','MarkerSize',10,'MarkerFaceColor','b')
    xlim([0.5 12.5])
    ylim([floor(trans_min) ceil(trans_max)])
    set(gca,'XTick',1:12)
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    set(gca,'YTick',floor(trans_min):2:ceil(trans_max))
    %set(gca,'YTick',floor(trans_min):ceil(trans_max))
    p1 = get(gca,'position');
    xlabel('Month');
    if mod(k,4) == 1
        ylabel('Sv')
        set(gca,'position',p1);
    else
        if mod(k,4) == 0
            p1(1) = p1(1) - 0.03*3;
            set(gca,'position',p1);
        else
            p1(1) = p1(1) - 0.03*(mod(k,4)-1);
            set(gca,'position',p1);
        end
    end
    p1(2) = p1(2) - 0.016*ceil(k/4-1);
    set(gca,'position',p1);
    if EB == 290
        title('Control Run MC Transport');
    else
        title(['Seasonal MC Transport  EB\_', num2str(EB),'E'])
    end
    %title('Seasonal Transport in Source Region of Kuroshio')
    set(gca,'fontsize',12)
    disp(['Processing : ',num2str(EB),'E'])
    clear h_trans v_trans
end
Trans_Sen = trans(1:end-1,:);
Trans_Ctrl = trans(end,:);
%save('../Output/8N_Trans_Sen.mat','Trans_Sen');
%save('../Output/8N_Trans_Ctrl.mat','Trans_Ctrl');
%% NEC 的流量 130E  8N-18N
% 源数据为 130E  0N - 30N
figure
clear;clc;
k = 0;
for EB = 290
    k = k + 1;
    delta_y = 6.371e6*0.25*pi/180;
    load(['../Input/OBC_trans_',num2str(EB),'E_h.mat']);
    H = h_trans(41,33:73,end-359:end) + 350;        % 122E - 130E  18N
    load(['../Input/OBC_trans_',num2str(EB),'E_NEC.mat']);
    v = trans_NEC(1,33:73,end-359:end);
    %16N-20N 平均
    %     a1=reshape(H,[33,17,30,12]); a2=reshape(v,[33,17,30,12]); %122E-130E 16N-20N
    %     b1=reshape(mean(a1,2),[33,30,12]);b2=reshape(mean(a2,2),[33,30,12]);
    %     H_trans = reshape(mean(b1,2),[33,12]);
    %     V_trans = reshape(mean(b2,2),[33,12]);
    
    a1=reshape(H,[41,30,12]); %122E-130E 16N-20N
    a2=reshape(v,[41,30,12]);
    H_trans = reshape(mean(a1,2),[41,12]);
    NEC_trans = reshape(mean(a2,2),[41,12]);
    for i = 1:12
        trans(k,i) = -NEC_trans(1:end-1,i)'*H_trans(1:end-1,i)*delta_y/10^6;
    end
    trans_min = min(trans(k,:));
    trans_max= max(trans(k,:));
    subplot(4,4,k);
    %trans(k,:) = smooth(trans(k,:));
    plot(trans(k,:),'-b','LineWidth',3.5)
    hold on
    plot(trans(k,:),'o','MarkerSize',10,'MarkerFaceColor','b')
    xlim([0.5 12.5])
    ylim([floor(trans_min) ceil(trans_max)])
    set(gca,'XTick',1:12)
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    %set(gca,'YTick',floor(trans_min):ceil(trans_max))
    p1 = get(gca,'position');
    xlabel('Month');
    if mod(k,4) == 1
        ylabel('Sv')
        set(gca,'position',p1);
    else
        if mod(k,4) == 0
            p1(1) = p1(1) - 0.03*3;
            set(gca,'position',p1);
        else
            p1(1) = p1(1) - 0.03*(mod(k,4)-1);
            set(gca,'position',p1);
        end
    end
    p1(2) = p1(2) - 0.016*ceil(k/4-1);
    set(gca,'position',p1);
    if EB == 290
        title('Control Run KC Transport');
    else
        title(['Seasonal KC Transport  EB\_', num2str(EB),'E'])
    end
    %title('Seasonal Transport in Source Region of Kuroshio')
    set(gca,'fontsize',12)
    disp(['Processing : ',num2str(EB),'E'])
    clear h_trans v_trans
end
Trans_Sen = trans(1:end-1,:);
Trans_Ctrl = trans(end,:);
%save('../Output/18N_Trans_Ctrl.mat','Trans_Ctrl');
%save('../Output/18N_Trans_Sen.mat','Trans_Sen');