% the explained ssh variance
h = zeros(1,16);
i = 1;
for EB = 160:10:290
    load(['../Output/H_',num2str(EB),'E_ECMWF.mat']);
    temp = H_NP(109:121,9:17,432);                      % 12-14N  127-130E
    h(i) = mean(temp(:));
    i = i + 1;
end
for n = 1:i-1
   S(n) = 1 - (h(i-1) - h(n))^2/h(i-1)^2;
end
format long

plot(1:14,100*S(1:14),'-bo')
xlim([1,14])