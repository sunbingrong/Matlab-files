%a = textscan('../Output/WENO_Burgers.dat','%f %f %f,','headerlines',3);
% a = importdata('../Output/Burgers_1_output.dat','%d %d %d');
% a = cell2mat(a.data);
% a = str2num(a);
clear
filename = '../Output/Burgers_1_output.dat';
delimiterIn = ' ';
headerlinesIn = 3;
linesIn = 10e5;
A = importdata(filename,delimiterIn,linesIn);
A = cell2mat(A(headerlinesIn+1:end,:));
A = str2num(A);
plot(A(:,1),A(:,2))
xlim([0,2*pi])
%%
clear
filename = '../Output/Burgers_output_0.17s_Upwind.dat';
A = importdata(filename);
plot(A(:,1)/(2*pi),A(:,2))
xlim([0,1])
ylim([-1,1])
%xlabel('x/(2*pi)');
xlabel({'$$ x/2 \pi $$'},'Interpreter','latex');
ylabel({'$$ u(x,t) $$'},'Interpreter','latex');
title({'$$ t = 0.17 s $$'},'Interpreter','latex');