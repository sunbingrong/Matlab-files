clc; 
clear all;
close all;
I = imread('F:/±¶±¶’’∆¨/photo/DSCF0286.JPG');
figure; hold on;
h1 = axes('position', [0.0 0.0 1.0 1.0], 'parent', gcf);
imshow(I, 'parent', h1);
h2 = axes('position', [0.2 0.2 0.5 0.5], 'parent', gcf);
axes(h2);
I1 = imread('rice.png');
imshow(I1, 'parent', h2);

