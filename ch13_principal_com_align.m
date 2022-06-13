clc; clear; close all;
addpath projects13;

f = imread('letterA_tilted.tif');
fAt = imbinarize(f);
subplot(2,2,1), imshow(fAt);

[x1, x2] = find(fAt);
X = [x1 x2];

P = principalComponents(X, 2);
Y = P.Y;
miny1 = min(Y(:,1));
miny2 = min(Y(:,2));
y1 = round(Y(:,1) - miny1 + min(x1));
y2 = round(Y(:,2) - miny2 + min(x2));

idx = sub2ind(size(fAt), y1, y2);
fout = false(size(fAt));
fout(idx) = 1;


fout = imclose(fout, ones(3));
% fout = rot90(fout, 2);
subplot(2,2,2), imshow(fout);