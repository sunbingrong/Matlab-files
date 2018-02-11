%% 年平均ssh的获得
clear;
load ssh.mat
[m,n,k] = size(ssh(1).A);
ssh_mean = zeros(m,n);
for i=1:length(ssh)
    ssh(i).A=sum(ssh(i).A,3)/k;
end
for i=1:length(ssh)
    ssh_mean = ssh_mean + ssh(i).A;
end
    ssh_mean = ssh_mean/length(ssh);
%% 年平均 salt的获得
clear;
load ssh.mat
[m,n,k] = size(ssh(1).A);
ssh_mean = zeros(m,n);
for i=1:length(ssh)
    ssh(i).A=sum(ssh(i).A,3)/k;
end
for i=1:length(ssh)
    ssh_mean = ssh_mean + ssh(i).A;
end
    ssh_mean = ssh_mean/length(ssh);
%% 
press=zeros(240,40);
format long;
for i=1:240
    [pres,dens]=my_pressure(depth,ssh_mean(1,i),reshape(temp(1,:,:),[240,40])',reshape(salt(1,:,:),[240,40])',lat(i));
     press(i,:) = pres;
end
%%
j=1;
for i=1:9:239
    a(j)=(press(i+1)-press(i))/0.3;
    j=j+1;
end