clear
load bifurcation_all.mat
STATM    = allstats(bifurcation_all);
a={STATM(2,:),STATM(3,:),STATM(4,:)};
%a={STATM(2,:)/STATM(2,1),STATM(3,:)/STATM(2,1),STATM(4,:)};
taylordiag(a{:})