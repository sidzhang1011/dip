clc; clear all; close all;

f = imread('house.jpg', 'jpg');
f = rgb2gray(f);
f = tofloat(f);
F = fft2(f);
S = fftshift(log(1 + abs(F)));
% imshow(S, []);

h = fspecial('sobel');
PQ = paddedsize(size(f));
H = freqz2(h, PQ(1), PQ(2));
H1 = ifftshift(H);

gs = 255 * imfilter(f, h);
gf = 255 * dftfilt(f, H1);

gd = abs(gs - gf);

subplot(2,2,1); imshow(abs(gs), [0 255]); title('spacial filtered image');
subplot(2,2,2); imshow(abs(gf), [0 255]); title('frequency filtered image');
subplot(2,2,3); imshow(gd, [0 255]); title('diff  image');



