clear; close all; clc;

f = imread('iceberg.png');
f = rgb2gray(f);
subplot(2,3,1), imshow(f);

k = 11;
% use kmeans segmenting the image
[idx, C] = kmeans(f(:), k);
fm = zeros(size(f));
for i = 1:k
    fm(idx == i) = C(i);
end
fm = reshape(fm, size(f, 1), size(f,2));
subplot(2,3,2), imshow(fm);

[L, NL] = superpixels(f, 100);
fs = zeros(size(f));
idx2 = label2idx(L);
for labelVar = 1:NL
    grayIdx = idx2{labelVar};
    fs(grayIdx) = mean(f(grayIdx));
end
mask = boundarymask(L);
fs = mat2gray(fs);
fso = imoverlay(fs, mask, 'w');

subplot(2,3,3), imshow(fs);
subplot(2,3,4), imshow(fso);