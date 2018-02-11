clc; clear; close all

for EB = 270
 
 nx = 1+(EB-100)*4;
 ny = 101;
 t  = 432;
 fid = fopen(['/home/user/sbr/sbr/box_Vorticity/Output/H_',num2str(EB),'E.dat'],'rb');
 data=fread(fid,inf,'real*4');
 fclose(fid);
 h = reshape(data,nx,ny,t);
 h(h==-9999) = NaN;
 
 %cMax=max(max(max(h)));
 %cMin=min(min(min(h)));
 %for mon = 1:t
 %   for i = 1:nx
 %       h(i,:,mon) = 600/(cMax-cMin).*h(i,:,mon)+300-600/(cMax-cMin)*cMax;
 %   end
 %end

 lon_area=[100 290]; lat_area=[10 35]; resolution = 0.25; % lon*lat 761*101

 h_NBL = -h(81:nx,1:41,:);           % 120E-EB  10N-20N
 h_mean = nanmean(h_NBL,3);
 aa = zeros(nx-80,41,t);
 for i = 1:t
    aa(:,:,i) = h_NBL(:,:,i)-h_mean;  % 120E-EB  10-20N
 end
 H_NP = h_NBL;
 H_a  = aa;
 
 a = zeros(nx-80,41,12);
  
 save(['/home/user/sbr/sbr/box_Vorticity/Output/H_',num2str(EB),'E.mat'],'H_NP');
 save(['/home/user/sbr/sbr/box_Vorticity/Output/H_a_',num2str(EB),'E.mat'],'H_a');


 max_H = max(max(max(H_NP)));
 min_H = min(min(min(H_NP)));

 for i=1:12
     sum = 0;
     for n = 1:36
         sum   = sum + aa(:,:,12*(n-1)+i);
     end
     a(:,:,i) = sum/36;
 end

 for i = 1:12
     b(:,i) = a(40,:,i);
 end

 NBL = b;
 save(['/home/user/sbr/sbr/box_Vorticity/Output/NBL_',num2str(EB),'E.mat'],'NBL')

 EB

end 
