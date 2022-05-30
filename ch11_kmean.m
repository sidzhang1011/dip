clc; clear; close all;

f = tofloat(imread('book-cover.tif'));
subplot(1,2,1), imshow(f);

k = 3;
% Working only with intensities, so Z[Z = f(:)] only has one column.
[L,C]= kmeans(f(:), k);
fseg = zeros(size(f));
for i = 1:k
    fseg(L == i) = C(i);
end
[m,n] = size(f);
fseg = reshape(fseg, m, n);
subplot(1,2,2), imshow(fseg, [0 1]);