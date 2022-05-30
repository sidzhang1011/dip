clc; clear; close all;

f = imread('noisy_stroke.tif');
subplot(2,3,1), imshow(f);

w = fspecial('average', 9);
g = imfilter(f, w, 'replicate');
subplot(2,3,2), imshow(g);

gbin = imbinarize(g);
subplot(2,3,3), imshow(gbin);

B = bwboundaries(gbin, 'noholes');
d = cellfun('length', B);
[maxd, k] = max(d);
b = B{k}; % Longest boundary.

% Display the boundary as an image.
[M, N] = size(gbin);
gb = bound2im(b, M, N);
gbc = imcolorcode(gb, [1 1 0]);
subplot(2,3,4), imshow(gbc);

% Determined experimentally to preserve the shape of the boundary.
scale = 0.025; 
bss = bsubsamp(b, scale, 8, M, N);
disp(size(b, 1))
disp(size(bss, 1))
% Rescale the small boundary for display.
bssr = bss/scale;
g2 = bound2im(bssr, M, N);

% Enlarge the points to make them easier to see and color them yellow:
se = ones(3);
g2c = imdilate(g2, se);
g2c = imcolorcode(g2c, [1 1 0]);
subplot(2,3,5), imshow(g2c);

cn = connectpoly(bssr(:, 1), bssr(:,2));
g3 = bound2im(cn, M, N);
g3c = imcolorcode(g3, [1 1 0]);
subplot(2,3,6), imshow(g3c);

% Obtain the Freeman chain code.
c = freemanChainCode(bss);
disp(c.x0y0)
disp(c.fcc)
disp(c.mm)
disp(c.diff)
disp(c.diffmm)
