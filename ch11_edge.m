clear; clc; close all;

f  = tofloat(imread('building.tif'));
% f  = tofloat(imread('yeast_cells.tif'));

% subplot(2,2,1), imshow(f);

% As a starting point, let edge find the threshold.
[gSobel_default, ts] = edge(f, 'sobel');
subplot(2,3,1), imshow(gSobel_default), title('sobel default');

[gLog_default, tlog] = edge(f, 'log');
subplot(2,3,2), imshow(gLog_default), title('log default');

[gCanny_default, tc] = edge(f, 'canny');
subplot(2,3,3), imshow(gCanny_default), title('canny default');


gSobel_best = edge(f, 'sobel', 0.12);
subplot(2,3,4), imshow(gSobel_best), title('sobel best');

gLog_best = edge(f, 'log', 0.011, 2.4);
subplot(2,3,5), imshow(gLog_best), title('log best');

gCanny_best = edge(f, 'canny', [0.08 0.2], 3.5);
subplot(2,3,6), imshow(gCanny_best), title('canny best');
