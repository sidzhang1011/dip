clc; clear; close all;

f = imread('nested-binary-regions.tif');
f = rgb2gray(f);
subplot(2,3,1), imshow(f);

BW = bwperim(f);
subplot(2,3,2), imshow(BW);

[B, L, NR, A] = bwboundaries(f, 8, 'holes');

% There are four external boundaries:
disp(NR)

% Two internal boundaries:
disp(length(B) - NR)

% Plot the elements of the label matrix L with a different color for each
% object using the jet color palette. We want zero values to map to black.
subplot(2,3,3), imshow(label2rgb(L, @jet, [0,0,0]));

% Plot boundaries. Colors 'b' or 'y' are not used here because they are
% hard to see against black and white, respectively.
colors = ['r' 'g' 'c' 'm' 'y' 'p'];
subplot(2,3,4), imshow(f);
hold on
for k = 1:length(B)
    boundary = B{k};
    % Repeat colors if there are more regions than colors. If the number of
    % colors is greater than 1, idx starts with the second color.
    idx = mod(k, length(colors)) + 1;
    plot(boundary(:,2), boundary(:,1), colors(idx), 'LineWidth', 2);
end
hold off

% To create an image that contains only one region, say 6 again,
k = 6;
region = zeros(size(f));
region(L == k) = 1;
subplot(2,3,5), imshow(region);