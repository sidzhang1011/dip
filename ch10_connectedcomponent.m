clear; close all; clc;
f = imread('blob-clusters.png');
f = rgb2gray(f);
f = double(f >= 128);
subplot(3,2,1), imshow(f);
cc = bwconncomp(f, 8);
L = labelmatrix(cc);
g = label2rgb(L, 'jet', [.7 .7 .7], 'shuffle');
subplot(3,2,2), imshow(g);

se = strel('disk', 60);
f2 = imdilate(f, se);
subplot(3,2,3), imshow(f2);
cc2 = bwconncomp(f2, 8);
L2 = labelmatrix(cc2);
g2 = label2rgb(L2, 'jet', [.7 .7 .7], 'shuffle');
subplot(3,2,4), imshow(g2);

L3 = L2;
L3(~f) = 0;
g3 = label2rgb(L3, 'jet', [.7 .7 .7], 'shuffle');
subplot(3,2,5), imshow(g3);

