%% 第五问
clear
x1=[185.15 201.43 280.28 383.02 326.39 352.22 ...
374.22 445.06 485.21 280.46 625.5 520.52];
x2=[98 98 189 229 65 255 89 130 222 ...
272 314 357]/10;
x3=[1.09 2.91 3.27 5 2.18 4.89 3.47 ...
8.37 14.8 6.45 6.26 4];
mengpiao=[18.09732 13.66384 44.3348 93.97524 ...
45.86108 87.07064 41.28224 61.70532 63.9584 ...
29.7988 82.70984 84.89024];
shangye=[74.41048 44.01952 90.44408 165.0732 ...
238.8278 67.19536 144.521 98.89816 212.6638 ...
61.948 168.7172 136.65];
A1=lsqcurvefit(@sss1,[1 1],x1,shangye);
z1=x1; z2=x1.*x3;z3=x1.*x2.*x3;z4=ones(1,12);
A2=regress(mengpiao',[z4',z1',z2',z3']);
%% 2016年收入
shenjia=561.3643;sheshi=11.1943;jiaolian=8.4251;
mengpiao2016=0.1824*shenjia-0.0038*shenjia*jiaolian+6.5141e-05*shenjia*sheshi*jiaolian-7.0136;
shangye2016=0.26233*shenjia+27.4160;
zhuanbo2016=149.6582;
jiangjin2016=24.9+37.4+5+3.635;
sumshouru2016=mengpiao2016+shangye2016+zhuanbo2016+jiangjin2016;
%% 2017年收入
mengpiao2018=(1+0.0992)*mengpiao2016;
shangye2017=(1+0.6015)*shangye2016;
zhuanbo2017=(1+0.3077)*149.6582;
jiangjin2017=24.9+37.4+5+3.635;
sumshouru2017=mengpiao2018+shangye2017+zhuanbo2017+jiangjin2017;
%% 2018年收入
mengpiao2018=(1+0.0992)*mengpiao2017;
shangye2018=(1+0.6015)*shangye2017;
zhuanbo2018=(1+0.3077)*(1+0.3077)*149.6582;
jiangjin2018=24.9+37.4+5+3.635;
sumshouru2018=mengpiao2018+shangye2018+zhuanbo2018+jiangjin2018;






