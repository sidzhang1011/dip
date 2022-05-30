clear; clc; close all;

f  = tofloat(imread('building.tif'));
subplot(3,2,1), imshow(f);

% As a starting point, let edge find the threshold.
[gv1, t1] = edge(f, 'sobel', 'vertical', 'nothinning');
subplot(3,2,2), imshow(gv1), title('sobel vertical');

[gv2, t2] = edge(f, 'sobel', 0.10, 'vertical', 'nothinning');
subplot(3,2,3), imshow(gv2), title('sobel vertical thresh');

[gv3, t3] = edge(f, 'sobel', 0.10, 'both', 'nothinning');
subplot(3,2,4), imshow(gv3), title('sobel thresh');

wpos45 = [0 1 2; -1 0 1; -2 -1 0];
gpos45 = imfilter(f, wpos45, 'replicate');
gpos45 = gpos45 >= 0.4*max(abs(gpos45(:)));
subplot(3,2,5), imshow(gpos45), title('+45');

wpos135 = [2 1 0; 1 0 -1; 0 -1 -2];
gpos135 = imfilter(f, wpos135, 'replicate');
gpos135 = gpos135 >= 0.4*max(abs(gpos135(:)));
subplot(3,2,6), imshow(gpos135), title('-45');

% [gv2, t2] = edge(f, 'log', 'vertical', 'nothinning');
% subplot(3,2,3), imshow(gv2), title('log edge');
% 
% [gv3, t3] = edge(f, 'canny');
% subplot(3,2,4), imshow(gv3), title('canny edge');
