%% Get Monthly Salt data
clear;clc
salt_fileFolder    = fullfile('D:\Applications\Matlab2015b\bin\bin文件\bin（2015）\GOADS_force\Output\GOADS_salt\');
pottemp_fileFolder = fullfile('D:\Applications\Matlab2015b\bin\bin文件\bin（2015）\GOADS_force\Output\GOADS_pottemp\');
GOADS_salt_files = dir([salt_fileFolder,'*.mat']);
load('../Output/GOADS_salt/GOADS_salt_198001.mat')
[nx,ny,nz] = size(salt);
%len=length(salt_fileFolder);
GOADS_pottemp_files = dir([pottemp_fileFolder,'*.mat']);
%len=length(GOADS_salt_files);
salt_temp = zeros(nx,ny,nz,12);  % salt temporary matrix
pottemp_temp = zeros(nx,ny,nz,12);  % temperature temporary matrix
year = 20;
for i=1:year*12;
    oldname = GOADS_salt_files(i).name;
    month   = str2double(oldname(end-5:end-4));
    salt_temp(:,:,:,month)    = salt_temp(:,:,:,month)    +   importdata([salt_fileFolder,oldname]);
    oldname = GOADS_pottemp_files(i).name;
    pottemp_temp(:,:,:,month) = pottemp_temp(:,:,:,month) +   importdata([pottemp_fileFolder,oldname]);
    i
end
GOADS_salt_monthly    = salt_temp/year;
GOADS_pottemp_monthly = pottemp_temp/year;
save('../Output/GOADS_salt_month.mat','GOADS_salt_monthly');
save('../Output/GOADS_pottemp_month.mat','GOADS_pottemp_monthly');
%% Get Monthly U&V data
clear;clc
u_fileFolder = fullfile('D:\Applications\Matlab2015b\bin\bin文件\bin（2015）\GOADS_force\Output\GOADS_u\');
v_fileFolder = fullfile('D:\Applications\Matlab2015b\bin\bin文件\bin（2015）\GOADS_force\Output\GOADS_v\');
GOADS_u_files = dir([u_fileFolder,'*.mat']);
load('../Output/GOADS_u/GOADS_u_198001.mat')
[nx,ny,nz] = size(u);
len_ufiles = length(GOADS_u_files);
GOADS_v_files = dir([v_fileFolder,'*.mat']);
len_vfiles = length(GOADS_v_files);
% add the value of nan in internal area of u&v
u_temp = zeros(nx,ny,nz,12);  % salt temporary matrix
v_temp = zeros(nx,ny,nz,12);  % temperature temporary matrix
year = 20;
for id = 1:year*12;
    u_oldname = GOADS_u_files(id).name;
    v_oldname = GOADS_v_files(id).name;
    month     = str2double(u_oldname(end-5:end-4));
    u         = importdata([u_fileFolder,u_oldname]);
    v         = importdata([v_fileFolder,v_oldname]);
    for i =2:nx-1
        for j = 2:ny-1
            for k = 1:nz
                B = u(i-1:i+1,j-1:j+1,month);
                C = v(i-1:i+1,j-1:j+1,month);
                if all(B(2:2:8)~=0) && isnan(B(5))==1
                    u(i,j,k) = 1/4*(u(i-1,j)+u(i+1,j)+u(i,j+1)+u(i,j-1));
                end
                if all(C(2:2:8)~=0) && isnan(C(5))==1
                    v(i,j,k) = 1/4*(v(i-1,j)+v(i+1,j)+v(i,j+1)+v(i,j-1));
                end
            end
        end
    end
    u_temp(:,:,:,month) = u_temp(:,:,:,month) + u;
    v_temp(:,:,:,month) = v_temp(:,:,:,month) + v;
    id
end
GOADS_u_monthly = u_temp/year;
GOADS_v_monthly = v_temp/year;
for month = 1:12
    for i =2:nx-1
        for j = 2:ny-1
            for k = 1:nz
                B = GOADS_u_monthly(i-1:i+1,j-1:j+1,k,month);
                C = GOADS_v_monthly(i-1:i+1,j-1:j+1,k,month);
                if all(B(2:2:8)~=0) && isnan(B(5)) == 1
                    GOADS_u_monthly(i,j,k,month) = 1/4*(GOADS_u_monthly(i-1,j,k,month)+GOADS_u_monthly(i+1,j,k,month)+ ...
                                                        GOADS_u_monthly(i,j+1,k,month)+GOADS_u_monthly(i,j-1,k,month));
                end
                if all(C(2:2:8)~=0) && isnan(C(5)) == 1
                    GOADS_v_monthly(i,j,k,month) = 1/4*(GOADS_v_monthly(i-1,j,k,month)+GOADS_v_monthly(i+1,j,k,month)+ ...
                                                        GOADS_v_monthly(i,j+1,k,month)+GOADS_v_monthly(i,j-1,k,month));
                end
            end
        end
    end
end
save('../Output/GOADS_u_month.mat','GOADS_u_monthly');
save('../Output/GOADS_v_month.mat','GOADS_v_monthly');