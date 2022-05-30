clear; clc; close all;

f = im2double(imread('yeast_cells.tif'));

subplot(2,2,1), imshow(f);
subplot(2,2,2), imhist(f);
% , 'ForegroundPolarity','bright'
t1 = adaptthresh(f, 0.58, 'Neigh', 9, ...
     'Stat','gaussian', 'Fore','bright');
g1 = imbinarize(f, t1);
subplot(2,2,3), imshow(g1);

% gCanny_best = edge(f, 'canny', [0.03 0.1], 2.5);
% subplot(2,2,4), imshow(gCanny_best), title('canny best'); 

label = bwlabel(g1);
subplot(2,2,4), imshow(label);