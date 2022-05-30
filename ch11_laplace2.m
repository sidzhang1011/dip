clear; clc; close all;

f = im2double(imread('yeast_cells.tif'));

subplot(2,3,1), imshow(f);
subplot(2,3,2), imhist(f);

w = [-1 -1 -1; -1 8 -1; -1 -1 -1];
lap = abs(imfilter(f, w, 'replicate'));
lap = lap/max(lap(:));

h = imhist(lap);

pc = percentile2i(h, 0.995);
markerImage = lap > pc;
subplot(2,3,3), imshow(markerImage);

fp = f.*markerImage;
subplot(2,3,4), imshow(fp);

hp = imhist(fp);
hp(1) = 0;
% Plot the histogram
subplot(2,3,5), bar(hp);

T = otsuthresh(hp);
T * (numel(hp) - 1)
g = imbinarize(f, T);
subplot(2,3,6), imshow(g)

