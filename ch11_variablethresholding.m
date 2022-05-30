clc; clear; close all;

f2 = imread('sine_shaded_text_image.tif');
subplot(2,2,1), imshow(f2);

T2Otsu = graythresh(f2);
g2Otsu = imbinarize(f2, T2Otsu);
subplot(2,2,2), imshow(g2Otsu);

T2pt7 = adaptthresh(f2, 0.7);
g2pt7 = imbinarize(f2, T2pt7);
subplot(2,2,3), imshow(g2pt7);

T2pt7n3 = adaptthresh(f2, 0.7, 'NeighborhoodSize', 3);
g2pt7n3 = imbinarize(f2, T2pt7n3);
subplot(2,2,4), imshow(g2pt7n3);