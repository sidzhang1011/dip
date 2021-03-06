clc; clear; close all;


% (a)
f = imread('national-archives-bld.tif');
f = rgb2gray(f);
subplot(2,4,1), imshow(f);

% Use default values for all parameters.
corners = detectMinEigenFeatures(f);
% Plot the corners superimposed on the image.
subplot(2,4,2), imshow(f);
hold on
plot(corners);
hold off;

size(corners)

corners2 = detectMinEigenFeatures(f, 'MinQuality', 0.1, 'FilterSize', 17);
subplot(2,4,3), imshow(f);
hold on
plot(corners2)
hold off;
size(corners2)

subplot(2,4,4), imshow(f);
hold on 
plot(corners2.selectStrongest(50));
hold off;


% (c).  
% Use default values for all parameters.
corners2 = eigenvalueCorners(f);
% Plot the corners superimposed on the image.
subplot(2,4,5), imshow(f);
hold on
plot(corners2, 'r+');
hold off;

corners3 = eigenvalueCorners(f, 0.3);
% Plot the corners superimposed on the image.
subplot(2,4,6), imshow(f);
hold on
plot(corners3, 'r+');
hold off;
