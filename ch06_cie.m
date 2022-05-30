clc; close all; clear all;

L = linspace(40, 80, 1024);
radius = 70;
theta = linspace(0, pi, 1024);
a = radius * cos(theta);
b = radius * sin(theta);

L = repmat(L, 100, 1);
a = repmat(a, 100, 1);
b = repmat(b, 100, 1);
lab_scale = cat(3, L, a, b);

cform = makecform('lab2srgb');
rgb_scale = applycform(lab_scale, cform);
imshow(rgb_scale);

xi = [0:255]';
z = interp1q([0 30 255]', [0 80 255]', xi);
figure, plot(xi, z);
s = spline([0 30 50 255]', [0 80 30 255]', xi);
figure, plot(xi, s);