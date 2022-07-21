clc; clear; close all;

f1 = imread('pill-bottle1.tif');
if ndims(f1) == 3
    f1 = rgb2gray(f1);
end

f2 = imread('pill-bottle2.tif');
if ndims(f2) == 3
    f2 = rgb2gray(f2);
end
f1 =imbinarize(f1, 177/255);
f2 =imbinarize(f2, 201/255);


[M, N] = size(f1);  % Images are of the same size.
subplot(2,3,1), imshow(f1);
subplot(2,3,4), imshow(f2);

[x1, y1] = im2minperpoly(f1, 8);
[x2, y2] = im2minperpoly(f2, 8);
 
% Compute the boundaries.
b1 = connectpoly(x1, y1);
b2 = connectpoly(x2, y2);
 
% Display the boundaries as images.
imb1 = bound2im(b1, M, N);
imb1 = imdilate(imb1, ones(3));
imb2 = bound2im(b2, M, N);
imb2 = imdilate(imb2, ones(3));

subplot(2,3,2), imshow(imb1);
subplot(2,3,5), imshow(imb2);

% Create two sets of six distorted boundaries. Use a displacement of four
% pixels in function randvertex, which simulates fairly large
% digitization/positional errors, as Figs. 14.6(c) and (f) show.
np = 6;
npix = 4;

for j = 1:np
    % Random vertices.
    [x1n{j}, y1n{j}] = randvertex(x1, y1, npix); 
    [x2n{j}, y2n{j}] = randvertex(x2, y2, npix);
    
    % Compute angles. The outputs are numerical vectors. 
    angles1{j} = polyangles(x1n{j}, y1n{j});
    angles2{j} = polyangles(x2n{j}, y2n{j});
    
    % Quantize the angles in 45-degree increments. 
    aq1{j} = floor(angles1{j}/45) + 1;
    aq2{j} = floor(angles2{j}/45) + 1;
    
    % Convert numerical vectors to character vectors. 
    v1{j} = int2str(aq1{j});
    v2{j} = int2str(aq2{j});
end

% Display two quantized boundary samples. 
b1n = connectpoly(x1n{1}, y1n{1});
b2n = connectpoly(x2n{1}, y2n{1});
imb1n = bound2im(b1n,M,N);
imb1n = imdilate(imb1n, ones(3));
imb2n = bound2im(b2n,M,N);
imb2n = imdilate(imb2n, ones(3));
subplot(2,3,3), imshow(imb1n);
subplot(2,3,6), imshow(imb2n);

% Compute similarity measures between strings of class 1. values are small,
% multipy them by 10 for display.
R11 = [];
for j = 1:np
    for k = 1:j
        R11(j, k) = 10*strsimilarity(v1{j}, v1{k});
    end
end
disp(R11);

% Similarity between v2 and v2.
R22 = [];
for j = 1:np
    for k = 1:j
        R22(j, k) = 10 * strsimilarity(v2{j}, v2{k});
    end
end
disp(R22);

% Similarity between v1 and v2.
R12 = [];
for j = 1:np
    for k = 1:np
        R12(j,k) = 10 * strsimilarity(v1{j}, v2{k});
    end
end
disp(R12);

