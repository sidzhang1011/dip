clc; clear; close all;

I = false(10); I(1:2, 1:2) = 1;  I(5:7, 5:7) = 1;
fdvalues = regionprops(I, 'Area');

values = regionprops(double(I), 'Area');

% fdvalues 1x2, values: 1x1

BW = imread('UTK.tif'); % Using > 0 sets the image to logical.
BW = rgb2gray(BW);
BW = BW > 0;
fdvalues = regionprops(BW, 'Image');
disp(fdvalues);
subplot(1,4,1), imshow(BW);

descp = fdvalues.Image;
subplot(1,4,2), imshow(fdvalues(1).Image);
subplot(1,4,3), imshow(fdvalues(2).Image);
subplot(1,4,4), imshow(fdvalues(3).Image);