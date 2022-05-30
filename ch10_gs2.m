clear; clc; close all;

f = imread('dowels.jpg');
f = imcomplement(f);
f = rgb2gray(f);
subplot(2,2,1),imshow(f);

se = strel('disk', 5);
fo = imopen(f, se);
subplot(2,2,2), imshow(fo);

foc = imclose(fo, se);
subplot(2,2,3), imshow(foc);

% morph_grad = fc - fo;
% subplot(2,2,4), imshow(morph_grad);