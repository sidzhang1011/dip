clc; clear all; close all;
I1 = imread('halfwb.jpg', 'jpg');
I = rgb2gray(I1);
F = fft2(I);

s = abs(F);

sf = fftshift(F);
ss = abs(sf);

ls = 15*log(1 + ss);
maxl = max(ls(:));
minl = min(ls(:));
ls = (255/(maxl-minl)) .*ls;
% 
phase = atan2(imag(F), real(F));

subplot(2,2,1), imshow(s, [0 255]), title('Fourier spectrum');
subplot(2,2,2), imshow(ss, [0 255]), title('Centered spectrum');
subplot(2,2,3), imshow(ls, [0 255]), title('Spectrum after log transform');
subplot(2,2,4), imshow(phase, [0 2*pi]), title('phase');
