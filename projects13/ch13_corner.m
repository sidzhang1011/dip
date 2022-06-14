clc; clear; close all;

f = imread('national-archives-bld.tif');
f = rgb2gray(f);
subplot(2,2,1), imshow(f);

% Use default values for all parameters.
corners = detectHarrisFeatures(f);
% Plot the corners superimposed on the image.
subplot(2,2,2), imshow(f);
hold on
plot(corners);
hold off;

size(corners)

corners2 = detectHarrisFeatures(f, 'MinQuality', 0.015, 'FilterSize', 17);
subplot(2,2,3), imshow(f);
hold on
plot(corners2)
hold off;
size(corners2)

subplot(2,2,4), imshow(f);
hold on 
plot(corners2.selectStrongest(50));
hold off;