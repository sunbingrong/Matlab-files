%% 显格式
clf;
figure;
subplot(1,2,1);plot(x,A1); %%模拟值
subplot(1,2,2);plot(x,A2,'r'); %%精确值
%% 4阶RK格式
clf;
figure;
subplot(1,2,1);plot(x,A3); %%模拟值
subplot(1,2,2);plot(x,A2,'r'); %%精确值