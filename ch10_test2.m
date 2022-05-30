clear; close all; clc;
f = imread('FigP0934.tif');
% Remove small blobs.
fsm = imclose(f, strel('disk', 30));

% Remove large blobs.
flrg = imopen(fsm, strel('disk', 60));

% Use a morphological gradient to obtain the boundary betwwen the regions.
se = ones(3);
grad = imsubtract(imdilate(flrg, se), imerode(flrg, se));

% superimpose the boundary on the original image.
idx = find(grad > 0);
final = f;
final(idx) = 255;

subplot(2,2,1), imshow(f);
subplot(2,2,2), imshow(fsm);
subplot(2,2,3), imshow(flrg);
subplot(2,2,4), imshow(final);