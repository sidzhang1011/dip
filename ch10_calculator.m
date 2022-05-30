clear; clc; close all;

f = imread('calculator.png');
f = rgb2gray(f);
% f = imopen(f,  strel('square', 3));
fb = double(f >= 128);
subplot(3,3,1),imshow(f);

f_obr = imreconstruct(imerode(fb, ones(1,71)), fb);
f_o = imopen(fb, ones(1,71)); % For comparison.
subplot(3,3,2), imshow(f_obr);
subplot(3,3,3), imshow(f_o)

f_thr = fb - f_obr;
f_th = fb - f_o;         % Or imtophat(f, ones(1, 71))
subplot(3,3,4), imshow(f_thr);
subplot(3,3,5), imshow(f_th);

g_obr = imreconstruct(imerode(f_thr, ones(1,11)), f_thr);
subplot(3,3,6), imshow(g_obr);

g_obrd = imdilate(g_obr, ones(1,21));
f2 = imreconstruct(min(g_obrd, f_thr), f_thr);
f2 = min(uint8(f2*255.0), f);

subplot(3,3,7), imshow(g_obrd);
subplot(3,3,9), imshow(f2, [0 255]);
