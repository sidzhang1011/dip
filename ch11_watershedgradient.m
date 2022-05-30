clc; clear; close all;

f = im2double(imread('liver-cells-gray.png'));
if ndims(f) == 3
    f = rgb2gray(f);
end

subplot(3,3,1), imshow(f);

g = imgradient(f);
subplot(3,3,2), imshow(g, []);

L = watershed(g);
ridges = L == 0;
subplot(3,3,3), imshow(ridges), title('ridges');

% Smooth the image.
fs = imgaussfilt(f, 0.02 * size(f,1));
subplot(3,3,4), imshow(fs);

% Compute the gradient.
gs = imgradient(fs);
subplot(3,3,5), imshow(gs, []);

Ls = watershed(gs);
ridgess = Ls == 0;
subplot(3,3,6), imshow(ridgess);

gsm = imhmin(gs, 0.01);
subplot(3,3,7), imshow(gsm, []);
Lsm = watershed(gsm);
ridgessm = Lsm == 0;
se = strel('line',11,20);
ridgessm = imdilate(ridgessm, se);
subplot(3,3,8), imshow(ridgessm, []);

fseg = f;
fseg(Lsm == 0) = 1;
% fsegc = imcolorcode(fseg, [1 0 0]);
subplot(3,3,9), imshow(fseg);

