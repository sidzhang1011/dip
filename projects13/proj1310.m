clc; clear; close all;
addpath ..;


% (a).
f1 = im2double(imread('headCT.tif'));
if ndims(f1) == 3
    f1 = rgb2gray(f1);
end

subplot(2,2,1), imshow(f1);

[regions, cc] = detectMSERFeatures(f1, 'RegionAreaRange', [300000  400000]);

% Show all the detected MSER regions superimposed on the image.
subplot(2,2,2), imshow(f1);
hold on
plot(regions, 'showPixelList', true, 'ShowEllipses', false);
hold off;

fdvalues = regionprops(cc, 'Area');
disp(fdvalues(1).Area)


% (b).
f2 = im2double(imread('building.tif'));
subplot(2,2,3), imshow(f2);
[regions, cc] = detectMSERFeatures(f2, 'ThresholdDelta', 28);
hold on
plot(regions, 'showPixelList', true, 'ShowEllipses', false);
hold off;

% count = 1, when ThresholdDelta = 27
disp(regions.Count)


% (c).
f2 = imgaussfilt(f2, 25, 'FilterSize', 151);
imarea = size(f2,1)*size(f2,2);
[regions, cc] = detectMSERFeatures(f2, 'ThresholdDelta', 15, 'RegionAreaRange', [int32(0.2*imarea) int32(0.8*imarea)]);
subplot(2,2,4), imshow(f2);
hold on
plot(regions, 'showPixelList', true, 'ShowEllipses', false);
hold off;
disp(regions.Count)
