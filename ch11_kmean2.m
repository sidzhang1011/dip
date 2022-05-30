clc; clear; close all;

f = tofloat(imread('flowers-red.jpeg'));
subplot(1,2,1), imshow(f);
R = f(:,:,1);
G = f(:,:,2);
B = f(:,:,3);
Z = [R(:) G(:) B(:)];

k = 3;
% Working only with intensities, so Z[Z = f(:)] only has one column.
[L,C]= kmeans(Z, k);
fseg = zeros(size(f,1), size(f,2));
for i = 1:k
    fseg(L == i) = C(i);
end
fseg = reshape(fseg, size(f,1), size(f,2));
subplot(1,2,2), imshow(fseg, [0 1]);