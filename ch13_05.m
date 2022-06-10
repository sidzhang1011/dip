clc; clear; close all;

f = imread('mapleleaf.tif');
subplot(2,4,1), imshow(f);

B = bwboundaries(f, 4, 'noholes');
b = B{1};

% Number of points on the boundary.
npb = size(b, 1);
[M, N] = size(f);
% Display the boundary as an image. Use cyan.
imb = bound2im(b, M, N);
subplot(2,4,2), imshow(imcolorcode(imb, [0 1 1]));

j = 3;
for i = [2, 4, 6, 8, 16, 32]
    [X, Y] = im2minperpoly(f, i);
    % Number of MPP vertices.
    nv2 = numel(X);
    b2 = connectpoly(X, Y);
    % Number of points on the boundary.
    npb2 = size(b2, 1);
    % Display the boundary as an image using cyan.
    imb2 = bound2im(b2, M, N);
    subplot(2,4,j),imshow(imcolorcode(imb2, [0 1 1]));
    j = j+1;
end