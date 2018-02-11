%%%%¡ª¡ª¡ª¡ª¡ªCode to draw the Arctic wind field(monthly means)¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
%-----------Created by ÃÍÅ£, Apr 23, 2012, modified by ÃÍÅ£, May 8,2012 appreciated what ÎÞ¾¶Ö®ÁÖ had pointed out£º£©---------------------
clear;clf;clc;
ncload uwnd.mon.mean.nc
ncload vwnd.mon.mean.nc
lati=lat(2:9);
long=lon;
long(length(long)+1)=0;

[x,y]=meshgrid(lon,lati);        % the original longitude
[xx,yy]=meshgrid(long,lati);     % the modified longitude adding the 0E column to the new longitude

for i=1:9      %-------------Year from 2003 to 2011-----------
    u=uwnd(55*12+(i-1)*12+1:55*12+(i-1)*12+12,:,:);      % choosing the monthly wind field data
    v=vwnd(55*12+(i-1)*12+1:55*12+(i-1)*12+12,:,:);
    for j=1:12
        uu=squeeze(u(j,2:9,:));
        vv=squeeze(v(j,2:9,:));
        [m n]=size(uu);
        
        R0=6371004;
        pi=3.1415926; 
        %---calculate deltx delty dx dy,and x y--units m actual location
        deltx(1:m)=2*pi*R0*cosd(lati)/360*mean(diff(lon));          % x lon (the actual distance of the resolution of data in longitude)
        for jj=1:n
            delty(jj)=2*pi*R0/360*abs(mean(diff(lati)));            % y lat (the actual distance of the resolution of data in latitude)
        end
        for kk=1:m
            rx(kk,:)=(deltx(kk):deltx(kk):n*deltx(kk));
        end
        for ll=1:n
            ry(:,ll)=(delty(ll):delty(ll):m*delty(ll));
        end
 
        subplot(1,2,1)
        m_proj('stereographic','lat',90,'long',215,'radius',25);
        div=divergence(rx,ry,uu,vv);            %-------Caculate the divergence--------
        div(:,size(div,2)+1)=div(:,1);          % add the 0E column data to the original 'div' matrix, so that when using m_pcolor the angle block won't appeared
        m_pcolor(xx,yy,div);
        shading interp;
        hold on
        m_quiver(x(:,1:3:end),y(:,1:3:end),uu(:,1:3:end),vv(:,1:3:end),0,'linewidth',0.5,'color','k','maxheadsize',2);
        m_coast('patch',[1 .8 .6],'edgecolor','k','linewidth',2);
        m_quiver(215,68.5,5,0,0,'r','linewidth',0.5,'maxheadsize',2);
        m_text(215,67,'5m/s','color','r','fontsize',13,'fontweight','bold');
        set(gca,'xtick',[1,9,17,25,33,41],'xticklabel',{'0¡ãE','60¡ãW','120¡ãW','180¡ãW','120¡ãE','60¡ãE'},'fontsize',16);
        m_grid('xtick',6,'tickdir','out','ytick',[ ],'linest','none');
        title('Divergence','FontSize',16);
        
        subplot(1,2,2)
        m_proj('stereographic','lat',90,'long',215,'radius',25); 
        curll=curl(rx,ry,uu,vv);                %-------Caculate the vorticity--------
        curll(:,size(curll,2)+1)=curll(:,1);    % add the 0E column data to the original 'div' matrix, so that when using m_pcolor the angle block won't appeared
        m_pcolor(xx,yy,curll);
        shading interp;
        hold on
        m_quiver(x(:,1:3:end),y(:,1:3:end),uu(:,1:3:end),vv(:,1:3:end),0,'linewidth',0.5,'color','k','maxheadsize',2);
        m_coast('patch',[1 .8 .6],'edgecolor','k','linewidth',2);
        m_quiver(215,68.5,5,0,0,'r','linewidth',0.5,'maxheadsize',2);
        m_text(215,67,'5m/s','color','r','fontsize',13,'fontweight','bold');
        set(gca,'xtick',[1,9,17,25,33,41],'xticklabel',{'0¡ãE','60¡ãW','120¡ãW','180¡ãW','120¡ãE','60¡ãE'},'fontsize',16);
        m_grid('xtick',6,'tickdir','out','ytick',[ ],'linest','none');
        title('Vorticity','FontSize',16);
        
        colorbar('location','southoutside','position',[0.1 0.1 0.84 0.05]);
        caxis([-2*10^-5 5*10^-5]);
        colormap(jet(21));
        saveas(gcf,strcat(num2str(i+2002),'_',num2str(j),'__','Arctic wind field(monthly means)','.emf'));
        clf
        clear uu vv div curll
    end
    clear u v
end




   
    
    





