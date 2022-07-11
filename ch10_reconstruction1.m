clear; clc; close all;

f = imread('book-text-bw.jpg');
f = rgb2gray(f);
f = double(f >= 128);
h = 25;
fe = imerode(f, ones(h,1));
subplot(3,2,1), imshow(f);
subplot(3,2,2), imshow(fe);

fo = imopen(f, ones(h,1));
fobr = imreconstruct(fe, f);
subplot(3,2,3), imshow(fo);
subplot(3,2,4), imshow(fobr);

g1 = imfill(f, 'holes');
subplot(3,2,5), imshow(g1);
g2 = imclearborder(f, 8);
subplot(3,2,6), imshow(g2);