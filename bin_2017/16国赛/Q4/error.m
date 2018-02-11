error_mean    = zeros(1,5);
error         = load('case026/lac.txt');
error_mean(1) = sum(error)/length(error); 
error         = load('case027/lac.txt');
error_mean(2) = sum(error)/length(error); 
error         = load('case028/lac.txt');
error_mean(3) = sum(error)/length(error); 
error         = load('case029/lac.txt');
error_mean(4) = sum(error)/length(error); 
error         = load('case030/lac.txt');
error_mean(5) = sum(error)/length(error); 
save('jingdu.mat','error_mean');
%% 精度与连接度数的关系
load('jingdu.mat')
a=jingdu(1,:);
b=jingdu(2,:)./jingdu(3,:);
plot(b,a,'bo');
xlabel('连接度数');
ylabel('精度')