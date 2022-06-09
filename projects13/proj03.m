clc; clear; close all;

% (a)
ia = imread('chromosome_boundary.tif');
aSize = size(ia);
se = strel('dis', 5, 0);       % Structuring element.
ia = imdilate(ia, se);
subplot(2,4,1), imshow(ia);

aboundary = bwboundaries(ia);
ad = cellfun('length', aboundary);
[maxdA, kA] = max(ad);
Abs = aboundary{kA}; % Longest boundary.
Af = bound2im(Abs, aSize(1), aSize(2));
subplot(2,4,2), imshow(Af);

for i = 3:8
    cellSize = 22 + 2*i;
    [aX, aY, aR] = im2minperpoly(Af, cellSize);
    subplot(2,4,i), imshow(aR);
end
% cellsize >= 34 

