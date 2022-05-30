clc; clear; close all;

f = imread('polymersomes.tif');
subplot(2,2,1), imshow(f);
subplot(2,2,2), imhist(f);
g = imbinarize(f, 169.4/255);
% g = imbinarize(f); % default Otsu
subplot(2,2,3), imshow(g);

% Otsu 
T = graythresh(f);
[counts, bins] = imhist(f, 256);
[T2, SM2] = otsuthresh(counts);
g2 = imbinarize(f, T2);
subplot(2,2,4), imshow(g2);

T - T2

