clc; clear all; close all;

f = checkerboard(8);    % > 0.5;
PSF = fspecial('motion', 7, 45);
gb = imfilter(f, PSF, 'circular');
noise = imnoise2('Gaussian', size(f,1), size(f,2), 0, sqrt(0.001));
g = gb + noise;


subplot(2,2,1); imshow(f, []); title('original image');
subplot(2,2,2); imshow(gb, []); title('noised image');
subplot(2,2,3); imshow(noise, []); title('noise image');
subplot(2,2,4); imshow(g, []); title('motion and gaussian noised image');
% subplot(2,3,5); imshow(P2, []); title('notch filter spectrum');
% subplot(2,3,6); imshow(g2, [0 255]); title('filtered image');

