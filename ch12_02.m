clc; clear; close all;

f = imread('nested-binary-regions.tif');
f = rgb2gray(f);
% subplot(2,3,1), imshow(f);
% 
% BW = bwperim(f);
% subplot(2,3,2), imshow(BW);
% 
[B, L, NR, A] = bwboundaries(f, 8, 'holes');
% 
% 
% 

BW1 = logical([1 0 0 0 0 0 0 0
               1 1 1 1 1 0 0 0
               1 0 0 0 1 0 1 0
               1 0 0 0 1 1 1 0
               1 1 1 1 0 1 1 1
               1 0 0 1 1 0 1 0
               1 0 0 0 1 0 1 0
               1 0 0 0 1 1 1 0]);
subplot(2,2,1), imshow(BW1, []);

BW2 = imfill(BW1, [3 3], 4);
subplot(2,2,2), imshow(BW2, []);

image = bound2im(B{4}, 400, 500);
subplot(2,2,3), imshow(image, [0 1]);

color = imcolorcode(image, [0 1 0], [1 0 1]);
subplot(2,2,4), imshow(color);

