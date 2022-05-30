clc; close all; clear all;

rgb_image = imread('image03.jpg');

[vg1, a1, ppg1] = colorgrad(rgb_image, 0);

[vg2, a2, ppg2] = colorgrad(rgb_image, 0.2);

vgdiff = abs(vg1 - vg2);
vgdiff = mat2gray(vgdiff);

subplot(2,3,1), imshow(rgb_image), title('original');
subplot(2,3,2), imshow(vg1), title('edge with T = 0');
subplot(2,3,3), imshow(ppg1), title('edge ppg with T = 0');
subplot(2,3,4), imshow(vg2), title('edge with T = 0.2');
subplot(2,3,5), imshow(ppg2), title('edge ppg with T = 0.2');
subplot(2,3,6), imshow(vgdiff), title('edge diff');

