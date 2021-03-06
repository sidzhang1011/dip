clc; clear; close all;

whole_image = zeros(512, 512, 'double');
whole_image(128:384,128:384) = 255.0;

% show original image
subplot(2,4,1), imshow(whole_image, [0 255]);


% Sobel
%sx = fspecial('sobel');
% sy = sx';
mx_sobel = [-1 -2 -1; 0 0 0; 1 2 1];
my_sobel = [-1 0 1; -2 0 2; -1 0 1];
gx_sobel = imfilter(whole_image, mx_sobel);
gy_sobel = imfilter(whole_image, my_sobel);
% gradient
grad_sobel = hypot(gx_sobel, gy_sobel);
grad_sobel = grad_sobel/max(grad_sobel(:));
subplot(2,4,2), imshow(grad_sobel);
% angle
angle_sobel = atand(gy_sobel ./ (gx_sobel + eps));
subplot(2,4,3), imshow(angle_sobel, [-90 90]);

