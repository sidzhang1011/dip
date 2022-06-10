clc; close all; clear;

square = imread('binary_triangle_distorted.tif');
subplot(2,2,1), imshow(square);

L = bwlabel(square);
d = diameter(L);
s = d.BasicRectangle;

subplot(2,2,2), plot(s, 'o--', 'linewidth', 2);

theta = pi/3.0;
T2 = [cos(theta) sin(theta); -sin(theta) cos(theta)];
% square1
ssize = size(square);
r = ssize(1);
c = ssize(2);
square1 = zeros(max(ssize)*2);

[idx(:,1), idx(:,2)] = find(ones(r,c));
idy = (idx - [r/2 c/2]) * T2;
idy = idy + [r c];
idy = round(idy);
 for i = 1:length(idx)
     square1(idy(i,1), idy(i,2)) = square(idx(i,1), idx(i,2));
 end


% for row=1:r
%     for col=1:c
%         nrc = [row-r/2 col-c/2] * T2 * T2';
%         newr = round(nrc(1) + r);
%         newc = round(nrc(2) + c);
%         square1(newr, newc) = square(row, col);
%     end
% end

subplot(2,2,3), imshow(square1);