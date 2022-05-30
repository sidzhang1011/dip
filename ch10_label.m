clear; close all; clc;
f = zeros(8, 8);
f(:,1) = 1;
f(:,2) = 1;
f(:,3) = 1;
f(2,5) = 1;
f(2,6) = 1;
f(3,5) = 1;
f(3,6) = 1;
f(4,7) = 1;
f(5,7) = 1;
f(6,7) = 1;
f(7,6) = 1;

[L, numel] = bwlabel(f, 4);
imshow(L, [0 5]);
cc = bwconncomp(f);