clc; clear all; close all;


% padding ±È½Ï
f = imread('halfwb.jpg', 'jpg');
f = rgb2gray(f);
[M, N] = size(f);
[f, revertclass] = tofloat(f);
F = fft2(f);
sig = 10;
H = lpfilter('gaussian', M, N, sig);
G = H.*F;
g = ifft2(G);
g = revertclass(g);
subplot(1,2,1); imshow(g); title('no padding image');

% PQ = paddedsize(size(f));
% Fp = fft2(f, PQ(1), PQ(2));
% Hp = lpfilter('gaussian', PQ(1), PQ(2), 2*sig);
% Gp = Hp.*Fp;
% gp = ifft2(Gp);
% gpc = gp(1:size(f,1), 1:size(f,2));
% gpc = revertclass(gpc);
PQ = paddedsize(size(f));
Hp = lpfilter('gaussian', PQ(1), PQ(2), 2*sig);
gpc = dftfilt(f,Hp);
subplot(1,2,2); imshow(gpc); title('padding image');



