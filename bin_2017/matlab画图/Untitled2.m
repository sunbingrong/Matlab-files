x=0:0.1:10;
y=x.^2+1;
plot(x,y)
set(gca, 'XTick', [0 1 2]);  %x轴的选点 or y轴的选点
set(gca, 'tickdir','out','ticklength',[0.005,0.025],'linewidth',1.2)   %轴线上的标线，朝外；线长；线宽
set(gca,'box','off'); %消除框图边的棱角
set(gca,'FontWeight', 'bold' , 'FontAngle', 'italic') 
%字体的粗细，黑体：字体的倾斜角度，'normal','italic',，一般和斜体
text(2,5,' \leftarrow 120^oE')
set(gca, 'YDir','reverse'); set(gca,'XAxisLocation','top')
%Y轴倒置，X轴放置顶部
%在指定位置设置一个文本标注
h1 = get(gca);  
%窗口的参数信息
h = get(gcf,'CurrentAxes')

