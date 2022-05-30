clc; clear; close all;

f1 = imread('spot_shaded_text_image.tif');
subplot(2,2,1), imshow(f1);

TOtsu = graythresh(f1);
g1Otsu =imbinarize(f1, TOtsu);
subplot(2,2,2), imshow(g1Otsu);

T1 = adaptthresh(f1);
g1 = imbinarize(f1, T1);
subplot(2,2,3), imshow(g1);

T1a = adaptthresh(f1, 0.7);
g1a = imbinarize(f1, T1a);
subplot(2,2,4), imshow(g1a);