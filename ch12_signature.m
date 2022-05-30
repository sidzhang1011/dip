clc; clear; close all;

square = imread('binary_square_distorted.tif');
subplot(2,3,1), imshow(square);

bSq = bwboundaries(square, 'noholes');
% Show boundary as an image.
imbSq = imcomplement(bound2im(bSq{1}, size(square, 1), size(square, 2)));
subplot(2,3,2), imshow(imbSq);

% Compute and display the signature.
dist = signature(bSq{1});
subplot(2,3,3), imshow(dist);