clear; close all; clc;

f = tofloat(imread('building.tif'));
subplot(2,2,1), imshow(f);
% gCanny_best = edge(f, 'canny', [0.06 0.2], 3.6);
gCanny_best = edge(f, 'canny', [0.04 0.16], 3.5);
subplot(2,2,2), imshow(gCanny_best);

% Obtain the Hough transform matrix.
[H, thetaV, rhoV] = hough(gCanny_best, 'thetaRes', 0.1);

% Display the transform as an image.
subplot(2,2,3), 
imshow(imadjust(mat2gray(H)), 'XData', thetaV, 'YData',rhoV, ...
    'Border','loose');
daspect auto;
axis on;
xlabel('\theta');
ylabel('\rho');

peaks = houghpeaks(H, 8);
hold on;
plot(round(thetaV(peaks(:,2))), rhoV(peaks(:,1)), 'LineStyle', 'none', ...
    'LineWidth', 3, 'Marker', 's', 'MarkerSize', 14, 'color', 'y');
hold off;

lines = houghlines(f, thetaV, rhoV, peaks, 'FillGap', 25);
subplot(2,2,4), imshow(f); hold on
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1), xy(:,2), 'LineWidth',3, 'Color','y');
end
hold off;