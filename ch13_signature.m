clc; clear; close all;

square = imread('binary_square_distorted.tif');
subplot(2,3,1), imshow(square);

B = strel('square', 17);
bSq = bwboundaries(square, 'noholes');
% Show boundary as an image.
imbSq = imcomplement(bound2im(bSq{1}, size(square, 1), size(square, 2)));
imbSqb = imbSq;
% imbSq = imdilate(imbSq, B);
% link 
temp = imcomplement(imbSq);
temp = imdilate(temp, B);
bSq2 = bwboundaries(temp, 'noholes');
temp = imcomplement(bound2im(bSq2{1}, size(square, 1), size(square, 2)));
subplot(2,3,2), imshow(temp);

% Compute and display the signature.
dist = signature(bSq{1});
subplot(2,3,3), plot(dist);


triangle = imread('binary_triangle_distorted.tif');
subplot(2,3,4), imshow(triangle);

bSq1 = bwboundaries(triangle, 'noholes');
% Show boundary as an image.
imbSq1 = imcomplement(bound2im(bSq1{1}, size(triangle, 1), ...
    size(triangle, 2)));
subplot(2,3,5), imshow(imbSq1);

% Compute and display the signature.
dist1 = signature(bSq1{1});
subplot(2,3,6), plot(dist1);