% Introduction
% basic��100E-70w ��ƽ���ķ紵������bifurcation
%��һ��Ϊ4�㣬�ڶ���Ϊ8�㣬������Ϊ12��
% bifur����һ��ͼ
clc
clear
dirs=dir('../Output/*PHI.dat');
% ������Ҫ��Ŀ¼�Լ��ļ���չ���滻����ȡĳ��Ŀ¼��ָ�������ļ��б����ؽṹ���顣
dircell=struct2cell(dirs)' ;
% �ṹ��(struct)ת����Ԫ������(cell)��ת��һ�������ļ����������С�
filenames=dircell(:,1) ; % ��һ�����ļ���
%��ȡ��������
%�����ļ�vel.mat;
EB = 150;
for t=1:length(filenames)
    a1=['../Output/',char(filenames(t))];
    fid = load(a1);
    bifur = fid(3601:end,2);
    a=reshape(bifur,[30,12,10]);
    b=sum(a,3)/10;
    c=sum(b)/30;
    subplot(4,4,t);
    %plot(1:24,[c c], '-bo','linewidth',1.5);
    plot(1:24,[c c], '-bo','Linewidth',2,'MarkerFaceColor','b','MarkerSize',4);
    p1 = get(gca,'position');
    set(gca,'XTick',1:24);
    set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
    xlabel('Month');
    if mod(t,4) == 1
        ylabel('Latitude(��N)');
        set(gca,'position',p1);
    else
        if mod(t,4) == 0
            p1(1) = p1(1) - 0.04*3;
            set(gca,'position',p1);
            set(gca,'YTickLabel','')
        else
            p1(1) = p1(1) - 0.04*(mod(t,4)-1);
            set(gca,'position',p1);
            set(gca,'YTickLabel','')
        end
    end
    p1(2) = p1(2) - 0.01*ceil(t/4-1);
    set(gca,'position',p1);
    if EB == 290
        title('Control Run');
    else
        title(['OBC  EB\_', num2str(EB),'E'])
    end
    EB = EB + 10;
    All_latitude(t,:)=c;
end
NBL_Sen = All_latitude(1:end-1,:);
NBL_Ctrl = All_latitude(end,:);
%save('../Output/NBL_Sen.mat','NBL_Sen');
%save('../Output/NBL_Ctrl.mat','NBL_Ctrl');
%% controlʵ��ķֲ��
fid = load('../Output/OBC290E_bifur_PHI.dat');
bifur = fid(3601:end,3);
a=reshape(bifur,[30,12,10]);
b=sum(a,3)/10;
c=sum(b)/30;
plot([1:24],[c c],'-bo','LineWidth',3,'MarkerFaceColor','b','MarkerSize',8)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
set(gca,'YLim',[13.6 15.2])
title('Control Run Bifurcation','FontSize',12);
set(gca,'FontSize',12)
xlabel('Month','FontSize',12);
ylabel('Latitude(��N)','FontSize',12);
% scrsz = get(0,'ScreenSize');
% set(gcf,'Position',scrsz);
% set(gcf, 'PaperPositionMode', 'auto')
%saveas(gcf,'../Output/control_bifur.bmp');
%% case180E�ֲ��
fid = importdata('../Output/test180E_bifur_PHI_mean.dat');
bifur = fid(3601:end,2);
a=reshape(bifur,[30,12,10]);
b=mean(a,3);
c=mean(b,1);
plot([1:24],[c c],'-bo','LineWidth',1.5)
set(gca,'XTick',1:24);
set(gca,'XTickLabel',{'J','F','M','A','M','J','J','A','S','O','N','D','J','F','M','A','M','J','J','A','S','O','N','D'});
xlabel('Month');

ylabel('Latitude(��N)');
%title('Control Run bifurcation')
% scrsz = get(0,'ScreenSize');
% set(gcf,'Position',scrsz);
% set(gcf, 'PaperPositionMode', 'auto')
%saveas(gcf,'../Output/180E_bifur.bmp');
%% ���ܺ�����
clear;
fid = load('../Output/dissi150E_stdout.dat');
kinetic = fid(:,4);
potential = fid(:,5);