clc; clear all; close all;

f = imread('manya.jpg');
f = rgb2gray(f);
[f, revertclass] = tofloat(f);
PQ = paddedsize(size(f));
[U,V] = dftuv(PQ(1), PQ(2));
D = hypot(U,V);
D0 = 0.05 * PQ(2);
F = fft2(f, PQ(1), PQ(2));
H = exp(-(D.^2)/(2*(D0^2)));
gz = dftfilt(f, H);
gz = revertclass(gz);

subplot(2,3,1); imshow(f, []); title('original image');
subplot(2,3,2); imshow(fftshift(H)); title('H(filter) frequency spectrum');
subplot(2,3,3); imshow(log(1+abs(fftshift(F))), []); title('F(image) frequency spectrum');
subplot(2,3,4); imshow(gz, [0 255]); title('frequency filtered image');


% % grid on;
% % axis on;
% mesh(fftshift(H));
% [az, el] = view
% view = [az + 10, 90]


