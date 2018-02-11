  % Program reduced gravity ocean model
  %      This is a 1-1/2 layer reduced gravity model
  %      with onliall nnear terms included. the resolution
  %	 id 1/4 degree in both lat and lon 
  %	 (code written on Oct. 19th, 2006 in OUC by Yang Jiayan)
  %	 revised into fortran 90 code by Xu Zhao
  imt   = 521; jmt = 151; 
  tstep =5;
  initial_depth=350;

  g    = 9.8*3.5/1025;
  rhow = 1025.0;
  a    = 6378400.0; 
  reso = 0.25;
  dt   = 3600/tstep;
  covis = 2000./(a*a)*ones(jmt,1);
  
  %  5.5e3 for 500m uniform depth, 3.5e3 for 1000m.
  % 3500 for 1000m is overflowed in 2001/11/19, here 4000 and 3000 are tried
  
  %------------the Loop---------------%
  
  
  %%----1. giving initial condition
  
  pi   = 4.0*atan(1.0) ;   
  omeg = 2.0*pi/(86400.0) ;             %% earth rotating rate
  dz   = reso*pi/180.0  ;               %% x, west-east  »¡¶È·Ö±æÂÊ
  dm   = reso*pi/180.0  ;               %% y, south-north
  
  vlat = (-19.875-0.5*reso)/180.0*pi;
  ulat = vlat + 0.5*reso/180.0*pi;
  hlat = ulat;

  %%------------ linear change for covis --------  30N-40N 2000->8000
  
  for j=201:jmt
      covis(j)=2000./(a*a)+(8000.-2000.)/40*(j-201)/(a*a);
  end
  
  %%--------------------------------------------------
  for j = 1:jmt
  
    UC1(j) = 0.5*omeg*sin((j-1)*dm+ulat);
    UP1(j) = -g/(a*dz*cos((j-1)*dm+ulat));  
    VC1(j) = -0.5*omeg*sin(dm*(j-1)+vlat);
    VP1(j) = -g/(a*dm);
    
    HA1(j) = 1./(a*dz*cos((j-1)*dm+hlat));
    HA2(j) = 1./(a*dm*cos((j-1)*dm+hlat));
    
    UD1(j) = covis(j)/(cos((j-1)*dm+ulat)^2*dz^2);
    UD2(j) = covis(j)/(dm^2);
    
    VD1(j) = covis(j)/(cos((j-1)*dm+vlat)^2*dz^2);
    VD2(j) = UD2(j);
   
    COSP(j) = cos(j*dm+vlat);
    COSM(j) = cos((j-1)*dm+vlat);
   
    UA1(j) = -1./(2.*a*cos((j-1)*dm+ulat)*dz);
    UA2(j) = -1./(2.*a*dm);
    VA1(j) = -1./(2.*a*cos((j-1)*dm+vlat)*dz);
    VA2(j) = -1./(2.*dm*a);
  end
  %%---------------------initial contion-----------------%%
  
  for i = 1:imt
    for j = 1:jmt
      u1(i,j,1) = 0.0;
      v1(i,j,1) = 0.0;
      h1(i,j,1) = 0.0;
      u1(i,j,2) = 0.0;
      v1(i,j,2) = 0.0;
      h1(i,j,2) = 0.0;
    end
  end
  
  %%-----------------  2. loading the coast  -----------------
  
  load('new_modeltopo_IP.mat');
  
  h0=new_modeltopo_IP;
  h0=h0';
  
  for i = 1:imt
    h0(i,1)   = 0.0;
    h0(i,jmt) = 0.0;
  end
  for j = 1:jmt
    h0(1,j)   = 0.0;
    h0(imt,j) = 0.0;
  end
  
 for j=1:jmt
	for i=1:imt
		if ( h0(i,j)>=0.5 )
            h0(i,j) = initial_depth;  %% initial layer depth
        end
    end
 end

%   ----------- 4. loop begins  -----------------
disp ( '1.5 reduced gravity model by Sun' )
disp ( 'Domain: North Pacific' )
X = sprintf('imt= %d jmt= %d',imt,jmt);
disp(X)
X = sprintf('time step = %d s', dt );
disp(X)
X = sprintf('initial depth= %d m', initial_depth );
disp(X)
X = sprintf( 'reduced gravity = %d ms-2', g');
disp(X)
disp ('------------------------------')
disp ('integration begins...')

for modelday=1
    
%%---read wind

taux=zeros(imt,jmt);
tauy=zeros(imt,jmt);

for i=1:imt
    for j=1:jmt
        taux(i,j)=1;
    end
end
taux=taux/rhow;
tauy=tauy/rhow;


%%--30-40N 1->0.2

for i=1:imt
    for j=201:jmt 
        taux(i,j)=taux(i,j)*(1.-(j-201)/40.*0.8);
        tauy(i,j)=taux(i,j)*(1.-(j-201)/40.*0.8);
    end
end

nw = 1;
nd = 2;

%%-------------- integration--------------------

        h = waitbar(0, 'Please wait...' );
        
        for nm = 1:1
            
          nt = nw;
          nw = nd;
          nd = nt;
          
          for j = 2:jmt-1
            for i = 2:imt-1
              
              if(abs(h0(i,j)) < 1) 
                h1(i,j,nw) = 0;
                v1(i,j,nw) = 0;
                u1(i,j,nw) = 0;
              end
              
              rg = 0;
              lg = 0;
              ug = 0;
              dg = 0;
              ld = 0;
              lu = 0;
              ru = 0;
              rd = 0;
              
              spv = 0;
              if(abs(h0(i+1,j) - spv) < 1 )   rg = 1;  end   %% right
              if(abs(h0(i-1,j) - spv) < 1 )   lg = 1;  end   %% left
              if(abs(h0(i,j+1) - spv) < 1 )   ug = 1;  end   %% up
              if(abs(h0(i,j-1) - spv) < 1 )   dg = 1;  end   %% down
          
              if(abs(h0(i-1,j-1) - spv) < 1 ) ld = 1;  end   %% left-down
              if(abs(h0(i-1,j+1) - spv) < 1 ) lu = 1;  end   %% left-up
              if(abs(h0(i+1,j+1) - spv) < 1 ) ru = 1;  end   %% right-up
              if(abs(h0(i+1,j-1) - spv) < 1 ) rd = 1;  end   %% right-down
              
              tg = rg+lg+ug+dg+ld+lu+ru+rd;
%               if any water thickness of 8 the grids is 0, then
              if(tg ~= 0) 
                
                if(ld == 1) 
                  u1(i-1,j-1,nd) = 0;
                  v1(i-1,j,nd)   = 0;
                end
                
                if(lu == 1) 
                  u1(i-1,j+1,nd) = 0;
                  v1(i-1,j+1,nd) = 0;
                end
                
                if(ru == 1) 
                  u1(i,j+1,nd)   = 0;
                  v1(i+1,j+1,nd) = 0;
                end
                
                if(rd == 1) 
                  v1(i+1,j,nd)   = 0;
                  u1(i,j-1,nd)   = 0;
                end
                
                if(dg == 1) 
                  v1(i,j,nd)     = 0;
                  v1(i,j-1,nd)   = 0;
                  h1(i,j-1,nd)   = h1(i,j,nd);
                end
                
                if(rg == 1) 
                  u1(i,j,nd)     = 0;
                  u1(i+1,j,nd)   = 0;
                  h1(i+1,j,nd)   = h1(i,j,nd);
                end
                
                if(lg == 1) 
                  u1(i-1,j,nd)   = 0;
                  h1(i-1,j,nd)   = h1(i,j,nd);
                end
                
                if(ug == 1) 
                  v1(i,j+1,nd)   = 0;
                  h1(i,j+1,nd)   = h1(i,j,nd);
                end
              end
              
              UC = UC1(j)*(v1(i,j,nd)+v1(i+1,j,nd)+v1(i+1,j+1,nd)+v1(i,j+1,nd));
              UP = UP1(j)*(h1(i+1,j,nd)-h1(i,j,nd));
              UD = UD1(j)*(u1(i+1,j,nd)+u1(i-1,j,nd)-2.*u1(i,j,nd)) + ...
                   UD2(j)*(u1(i,j+1,nd)+u1(i,j-1,nd)-2.*u1(i,j,nd));
              UA = UA1(j)*(u1(i+1,j,nd)-u1(i-1,j,nd))*u1(i,j,nd)  +   ...
                   UA2(j)*(u1(i,j+1,nd)-u1(i,j-1,nd))*(v1(i,j,nd) +   ...
                   v1(i+1,j,nd)+v1(i,j+1,nd)+v1(i+1,j+1,nd))*0.25;
              hu = (h0(i,j)+h1(i,j,nd)+h0(i+1,j)+h1(i+1,j,nd))/2;
              
              if(hu<75.0) 
                  hu = 75.0; 
              end
              
              u1(i,j,nw)=u1(i,j,nd)+dt*(UC+UP+UD+UA+taux(i,j)/hu);
              
              VC = VC1(j)*(u1(i-1,j-1,nd)+u1(i,j-1,nd)+u1(i,j,nd)+u1(i-1,j,nd));
              VP = VP1(j)*(h1(i,j,nd)-h1(i,j-1,nd));
              VD = VD1(j)*(v1(i+1,j,nd)+v1(i-1,j,nd)-2.*v1(i,j,nd)) +  ...
                   VD2(j)*(v1(i,j+1,nd)+v1(i,j-1,nd)-2.*v1(i,j,nd));
              VA = VA1(j)*(v1(i+1,j,nd)-v1(i-1,j,nd))*(u1(i,j,nd)   +  ...
                   u1(i-1,j,nd)+u1(i,j-1,nd)+u1(i-1,j-1,nd))*0.2    +  ...
                   VA2(j)*(v1(i,j+1,nd)-v1(i,j-1,nd))*v1(i,j,nd);
              hv = (h0(i,j)+h1(i,j,nd)+h0(i,j-1)+h1(i,j-1,nd))/2;
              
              if(hv<75.0) 
                  hv = 75.0; 
              end
              
              v1(i,j,nw) = v1(i,j,nd)+dt*(VC+VP+VD+VA+tauy(i,j)/hv);
              
              hu1 = (h0(i+1,j)+h1(i+1,j,nd)+h0(i,j)+h1(i,j,nd))/2.0;
           
              hu2 = (h0(i-1,j)+h1(i-1,j,nd)+h0(i,j)+h1(i,j,nd))/2.0;
            
              hv1 = (h0(i,j+1)+h1(i,j+1,nd)+h0(i,j)+h1(i,j,nd))/2.0;
             
              hv2 = (h0(i,j-1)+h1(i,j-1,nd)+h0(i,j)+h1(i,j,nd))/2.0;
             
              HA = HA1(j)*(u1(i,j,nd)*hu-u1(i-1,j,nd)*hu2)+ ...
                   HA2(j)*(v1(i,j+1,nd)*COSP(j)*hv1-v1(i,j,nd)*COSM(j)*hv2);
     
              h1(i,j,nw)=h1(i,j,nd)-dt*HA ;
            end
          end
        end
          
         for me = 1:tstep-1
             
             waitbar(me / tstep)
         
            nt = nw;
            nw = nd;
            nd = nt;
            
            for j = 2:jmt-1
              for i = 2:imt-1
                
                if(abs(h0(i,j)) < 1e-5) 
                  h1(i,j,nw) = 0;
                  v1(i,j,nw) = 0;
                  u1(i,j,nw) = 0;
                end
                
                rg = 0;
                lg = 0;
                ug = 0;
                dg = 0;
                ld = 0;
                lu = 0;
                ru = 0;
                rd = 0;
                
                spv = 0.0;
                if(abs(h0(i+1,j) - spv) < 1e-5 )   rg = 1;   end
                if(abs(h0(i-1,j) - spv) < 1e-5 )   lg = 1;   end
                if(abs(h0(i,j+1) - spv) < 1e-5 )   ug = 1;   end
                if(abs(h0(i,j-1) - spv) < 1e-5 )   dg = 1;   end
                if(abs(h0(i-1,j-1) - spv) < 1e-5 ) ld = 1;   end
                if(abs(h0(i-1,j+1) - spv) < 1e-5 ) lu = 1;   end
                if(abs(h0(i+1,j+1) - spv) < 1e-5 ) ru = 1;   end
                if(abs(h0(i+1,j-1) - spv) < 1e-5 ) rd = 1;   end
                
                tg = rg+lg+ug+dg+ld+lu+ru+rd;
                
                if(tg ~= 0)  
                  
                  if(ld == 1) 
                    u1(i-1,j-1,nd)  = 0;
                    v1(i-1,j,nd)    = 0;
                  end
                  
                  if(lu == 1) 
                    u1(i-1,j+1,nd)  = 0;
                    v1(i-1,j+1,nd)  = 0;
                  end
                  
                  if(ru == 1) 
                    u1(i,j+1,nd)    = 0;
                    v1(i+1,j+1,nd)  = 0;
                  end
                  
                  if(rd == 1) 
                    v1(i+1,j,nd)    = 0;
                    u1(i,j-1,nd)    = 0;
                  end
                  
                  if(dg == 1) 
                    v1(i,j,nd)      = 0;
                    v1(i,j-1,nd)    = 0;
                    h1(i,j-1,nd)    = h1(i,j,nd);
                  end
                  
                  if(rg == 1) 
                    u1(i,j,nd)      = 0;
                    u1(i+1,j,nd)    = 0;
                    h1(i+1,j,nd)    = h1(i,j,nd);
                  end
                  
                  if(lg == 1) 
                    u1(i-1,j,nd)    = 0;
                    h1(i-1,j,nd)    = h1(i,j,nd);
                  end
                  
                  if(ug == 1) 
                    v1(i,j+1,nd)    = 0;
                    h1(i,j+1,nd)    = h1(i,j,nd);
                  end
                end
                
                UC = UC1(j)*(v1(i,j,nd)+v1(i+1,j,nd)+v1(i+1,j+1,nd)+v1(i,j+1,nd));
                UP = UP1(j)*(h1(i+1,j,nd)-h1(i,j,nd));
                UD = UD1(j)*(u1(i+1,j,nd)+u1(i-1,j,nd)-2.*u1(i,j,nd)) + ...
                     UD2(j)*(u1(i,j+1,nd)+u1(i,j-1,nd)-2.*u1(i,j,nd));
                UA = UA1(j)*(u1(i+1,j,nd)-u1(i-1,j,nd))*u1(i,j,nd)+ ...
                     UA2(j)*(u1(i,j+1,nd)-u1(i,j-1,nd))*(v1(i,j,nd)+ ...
                     v1(i+1,j,nd)+v1(i,j+1,nd)+v1(i+1,j+1,nd))*0.25;
                
                hu = (h0(i,j)+h1(i,j,nd)+h0(i+1,j)+h1(i+1,j,nd))/2;
                
                if(hu<75.0) 
                    hu = 75.0; 
                end
                    
                u1(i,j,nw)=u1(i,j,nw)+2.*dt*(UC+UP+UD+UA+taux(i,j)/hu);
                
                VC = VC1(j)*(u1(i-1,j-1,nd)+u1(i,j-1,nd)+u1(i,j,nd)+u1(i-1,j,nd));
                VP = VP1(j)*(h1(i,j,nd)-h1(i,j-1,nd));
                VD = VD1(j)*(v1(i+1,j,nd)+v1(i-1,j,nd)-2.*v1(i,j,nd)) ...
                     +VD2(j)*(v1(i,j+1,nd)+v1(i,j-1,nd)-2.*v1(i,j,nd)) ;
                VA = VA1(j)*(v1(i+1,j,nd)-v1(i-1,j,nd))*(u1(i,j,nd)+ ...
                     u1(i-1,j,nd)+u1(i,j-1,nd)+u1(i-1,j-1,nd))/4.+ ...
                     VA2(j)*(v1(i,j+1,nd)-v1(i,j-1,nd))*v1(i,j,nd);
                
                hv = (h0(i,j)+h1(i,j,nd)+h0(i,j-1)+h1(i,j-1,nd))/2;
                
                if(hv<75.0) 
                    hv = 75.0; 
                end
                    
                v1(i,j,nw)=v1(i,j,nw)+2.*dt*(VC+VP+VD+VA+tauy(i,j)/hv);
                
              hu1 = (h0(i+1,j)+h1(i+1,j,nd)+h0(i,j)+h1(i,j,nd))/2.0;
              
              hu2 = (h0(i-1,j)+h1(i-1,j,nd)+h0(i,j)+h1(i,j,nd))/2.0;
              
              hv1 = (h0(i,j+1)+h1(i,j+1,nd)+h0(i,j)+h1(i,j,nd))/2.0;
             
              hv2 = (h0(i,j-1)+h1(i,j-1,nd)+h0(i,j)+h1(i,j,nd))/2.0;
            
              HA = HA1(j)*(u1(i,j,nd)*hu-u1(i-1,j,nd)*hu2)+ ...
                   HA2(j)*(v1(i,j+1,nd)*COSP(j)*hv1-v1(i,j,nd)*COSM(j)*hv2); 
         
              h1(i,j,nw)=h1(i,j,nw)-2.*dt*HA;
              end
            end
         end
         waitbar(1,h,'Mission Complete ! ! !')
         pause(1.5);
         close(h);
%%-----------------integration over---------
uu=u1(:,:,nw);
vv=v1(:,:,nw);
hh=h1(:,:,nw);

if(min(h1)<=-350)   %% ave value should be less than 10
   disp( 'outcrops !!!!');
end

end %%  modelday
disp('-----------------------')
disp('Mission Complete !')