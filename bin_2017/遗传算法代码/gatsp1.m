%GATSP.m
function gatsp1()
clear;
distTSP=textread('C:\Users\M\Desktop\distTSP.txt');
distance = distTSP;
N = 5;
ngen = 100;
ngpool = 10;
%ngen = input('# of generations to evolve = ');
%ngpool = input('# of chromosoms in the gene pool = '); % size of genepool
gpool = zeros(ngpool,N+1); % gene pool
for i = 1:ngpool, % intialize gene pool ,初始化基因池，且每条路线不相同
    gpool(i,:) = [1 randomize([2:N]')' 1]; 
    for j  = 1:i-1
        while gpool(i,:) == gpool(j,:) 
            gpool(i,:) = [1 randomize([2:N]')' 1]; 
        end
    end
end
costmin = 100000; 
tourmin = zeros(1,N); 
cost = zeros(1,ngpool); 
increase = 1;resultincrease=1;
for i = 1:ngpool 
    cost(i) = sum(diag(distance(gpool(i,:)',rshift(gpool(i,:))')));    %计算的路线的结果应该是倒置的
end
% record current best solution
[costmin,idx] = min(cost);
tourmin = gpool(idx,:);
disp([num2str(increase) 'minmum trip length = ' num2str(costmin)])
%善于利用算法计算具体数值和位置

costminold2 = 200000;costminold1 = 150000;resultcost = 100000;
tourminold2 = zeros(1,N);
tourminold1 = zeros(1,N);
resulttour = zeros(1,N);
while (abs(costminold2-costminold1) > 100)&(abs(costminold1-costmin) > 100)&(increase < 500) 

costminold2 = costminold1; tourminold2 = tourminold1; 
costminold1 = costmin;tourminold1 = tourmin; 
increase = increase+1; 
if resultcost > costmin 
    resultcost = costmin; 
    resulttour = tourmin; 
    resultincrease = increase-1; 
end 
for i = 1:ngpool, 
    cost(i) = sum(diag(distance(gpool(i,:)',rshift(gpool(i,:))'))); 
end 
% record current best solution 
[costmin,idx] = min(cost); 
tourmin = gpool(idx,:); 
%============== 
% copy gens in th gpool according to the probility ratio 
% >1.1 copy twice 
% >=0.9 copy once 
% ;0.9 remove 
[csort,ridx] = sort(cost); 
% sort from small to big. 
csum = sum(csort); 
caverage = csum/ngpool; 
cprobilities = caverage./csort; 
copynumbers = 0;removenumbers = 0; 
for i = 1:ngpool, 
    if cprobilities(i) > 1.1 
        copynumbers = copynumbers+1; 
    end
    if cprobilities(i) < 0.9
        removenumbers = removenumbers+1; 
    end
end
copygpool = min(copynumbers,removenumbers); 
for i = 1:copygpool 
    for j = ngpool:-1:2*i+2 
        gpool(j,:) = gpool(j-1,:); 
    end
    gpool(2*i+1,:) = gpool(i,:);
end 
if copygpool == 0 
    gpool(ngpool,:) = gpool(1,:); 
end 
%========= 
%when genaration is more than 50,or the patterns in a couple are too close,do mutation 
for i = 1:ngpool/2 
    sameidx = [gpool(2*i-1,:) == gpool(2*i,:)]; 
    diffidx = find(sameidx == 0); 
    if length(diffidx) <= 2 
        gpool(2*i,:) = [1 randomize([2:N]')' 1];   
    end
end
%=========== 
%cross gens in couples 
for i = 1:ngpool/2 
    [gpool(2*i-1,:),gpool(2*i,:)] = crossgens(gpool(2*i-1,:),gpool(2*i,:)); 
end 

for i = 1:ngpool, 
    cost(i) = sum(diag(distance(gpool(i,:)',rshift(gpool(i,:))'))); 
end 
% record current best solution 
[costmin,idx] = min(cost); 
tourmin = gpool(idx,:); 
disp([num2str(increase) 'minmum trip length = ' num2str(costmin)])
disp(num2str(tourmin))
end 

disp(['cost function evaluation: ' int2str(increase) ' times!'])
disp(['n:' int2str(resultincrease)])
disp(['minmum trip length = ' num2str(resultcost)])
disp('optimum tour = ')
disp(num2str(resulttour)) 
%====================================================

