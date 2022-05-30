clc; clear; close all;

f = imread('gaussian_noise_mean_0_std_50_added.tif');
subplot(2,2,1), imshow(f);

T = graythresh(f);
g = imbinarize(f, T);
subplot(2,2,2), imshow(g), title('Otsu thresholding');

filter = 1/25.0 * ones(5);
filtered_image = imfilter(f, filter);
T2 = graythresh(filtered_image);
g2 = imbinarize(filtered_image, T2);
subplot(2,2,3), imshow(g2);