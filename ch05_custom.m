clc; clear all; close all;

f = imread('house.jpg', 'jpg');
f = rgb2gray(f);
f = tofloat(f);

forward_fcn = @(wz, tdata) [3*wz(:,1), 2*wz(:,2)]
inverse_fcn = @(xy, tdata) [xy(:,1)/3, xy(:,2)/2]
tform1 = maketform('custom', 2, 2, forward_fcn, ...
    inverse_fcn, []);

forward_fcn2 = @(wz, tdata) [wz(:, 1) + 0.4*wz(:, 2), wz(:, 2)];
inverse_fcn2 = @(xy, tdata) [xy(:, 1) - 0.4*xy(:, 2), xy(:, 2)];
tform2 = maketform('custom', 2, 2, forward_fcn2, inverse_fcn2, []);

WZ = [1 1; 3 2];
XY = tformfwd(WZ, tform1)
WZ2 = tforminv(XY, tform1)

p = pointgrid([0 0; 100 100]);

vistform(tform1, pointgrid([0 0; 100 100]))
figure, vistform(tform2, pointgrid([0 0; 100 100]))

T = [1 0 0; 0.4 1 0; 0 0 1];
tform3 = maketform('affine', T);
WZ3 = [1 1; 3 2];
XY3 = tformfwd(WZ, tform3)

% 
% subplot(2,2,1); imshow(abs(gs), [0 255]); title('spacial filtered image');
% subplot(2,2,2); imshow(abs(gf), [0 255]); title('frequency filtered image');
% subplot(2,2,3); imshow(gd, [0 255]); title('diff  image');



