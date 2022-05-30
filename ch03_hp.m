clc; clear all; close all;

fo = imread('manya.jpg');
f = rgb2gray(fo);
[f, revertclass] = tofloat(f);
PQ = paddedsize(size(f));
[U,V] = dftuv(PQ(1), PQ(2));
D = hypot(U,V);
D0 = 0.05 * PQ(2);
F = fft2(f, PQ(1), PQ(2));
H = hpfilter('gaussian', PQ(1), PQ(2), D0);
gz = dftfilt(f, H);
gz = revertclass(gz);

subplot(1,2,1); imshow(fo, []); title('original image');
subplot(1,2,2); imshow(gz); title('high-pass filtered image');


% % grid on;
% % axis on;
% mesh(fftshift(H));
% [az, el] = view
% view = [az + 10, 90]


