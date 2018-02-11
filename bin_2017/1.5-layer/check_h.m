clear
for i=140:10:250
     str1=num2str(i);
     str2='E_uvh.mat';
     str3=[str1,str2];
     load(str3)
contour(h(:,:,720)');
my_handle=colorbar;
set(get(my_handle,'title'),'string','m');
saveas(gca,['h_',num2str(i),'E_720.pdf'])
contour(h(:,:,360)')
my_handle=colorbar;
set(get(my_handle,'title'),'string','m');
saveas(gca,['h_',num2str(i),'E_360.pdf'])
end