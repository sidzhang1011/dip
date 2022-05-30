clc; clear all; close all;

f = imread('house.jpg');
f = rgb2gray(f);
g = imnoise(f, 'salt & pepper', .25);

f1 = medfilt2(g, [7 7], 'symmetric');
f2 = adpmedian(g, 7);

subplot(2,2,1); imshow(f, []); title('original image');
subplot(2,2,2); imshow(g, [0 255]); title('noised image');
subplot(2,2,3); imshow(f1, []); title('median image');
subplot(2,2,4); imshow(f2, [0 255]); title('adaptive median image');
% subplot(2,3,5); imshow(P2, []); title('notch filter spectrum');
% subplot(2,3,6); imshow(g2, [0 255]); title('filtered image');

