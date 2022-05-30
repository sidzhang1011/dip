clear; clc; close all;

f = imread('aerial-view.jpeg');
subplot(2,2,1),imshow(f);

se = strel('square', 3);
gd = imdilate(f, se);
subplot(2,2,2), imshow(gd);

ge = imerode(f, se);
subplot(2,2,3), imshow(ge);

morph_grad = gd - ge;
subplot(2,2,4), imshow(morph_grad);