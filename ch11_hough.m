clear; close all; clc;
f = zeros(101, 101);
f(1,1) = 1; f(101,1) = 1; f(1,101) = 1; f(101,101) = 1; f(51,51) = 1;
% Points are shown in red for clarity.
frgb = zeros(101,101,3);
frgb(:,:,1) = f;
subplot(2,2,1), imshow(f);

[H, thetaV, rhoV] = hough(f);
nr = numel(rhoV);
nc = numel(thetaV);
% Display hough curves in yellow.
Hrgb = zeros(nr, nc, 3);
Hrgb(:,:,1) = H;
Hrgb(:,:,2) = H;
subplot(2,2,2), imshow(Hrgb, 'XData', thetaV, 'YData',rhoV, ...
    'Border','loose');
axis on;
xlabel('\theta');
ylabel('\rho');