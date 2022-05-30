clc; close all; clear all;
rgb = imread('image01.jpg');
% [X, map] = rgb2ind(rgb, 256);
% 
% rgb_image = ind2rgb(X, map);

[X1, map1] = rgb2ind(rgb, 8, 'nodither');
[X2, map2] = rgb2ind(rgb, 8, 'dither');

g = rgb2gray(rgb);
g1 = dither(g);

figure,
subplot(1,2,1), imshow(X1, map1);
subplot(1,2,2), imshow(X2, map2);
figure,
subplot(1,2,1), imshow(g);
subplot(1,2,2), imshow(g1);