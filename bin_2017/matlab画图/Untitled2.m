x=0:0.1:10;
y=x.^2+1;
plot(x,y)
set(gca, 'XTick', [0 1 2]);  %x���ѡ�� or y���ѡ��
set(gca, 'tickdir','out','ticklength',[0.005,0.025],'linewidth',1.2)   %�����ϵı��ߣ����⣻�߳����߿�
set(gca,'box','off'); %������ͼ�ߵ����
set(gca,'FontWeight', 'bold' , 'FontAngle', 'italic') 
%����Ĵ�ϸ�����壺�������б�Ƕȣ�'normal','italic',��һ���б��
text(2,5,' \leftarrow 120^oE')
set(gca, 'YDir','reverse'); set(gca,'XAxisLocation','top')
%Y�ᵹ�ã�X����ö���
%��ָ��λ������һ���ı���ע
h1 = get(gca);  
%���ڵĲ�����Ϣ
h = get(gcf,'CurrentAxes')

