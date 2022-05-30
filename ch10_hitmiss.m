clc; clear; close all;
fun = @(x) isequal(x, [1 1 0; 1 1 0; 1 1 0]);
lut = makelut(fun, 3);
f = imread('book-text-bw.tiff');
f = rgb2gray(f);
f = double(f > 128);
g = bwlookup(f, lut);
subplot(1,2,1), imshow(f);
subplot(1,2,2), imshow(g);