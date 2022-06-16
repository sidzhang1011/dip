clc; clear; close all;

f = im2double(imread('headCT.tif'));
if ndims(f) == 3
    f = rgb2gray(f);
end

subplot(2,3,1), imshow(f);

[regions, ~] = detectMSERFeatures(f);

% Show all the detected MSER regions superimposed on the image.
subplot(2,3,2), imshow(f);
hold on
plot(regions, 'showPixelList', true, 'ShowEllipses', false);
hold off;

disp(regions)

[regions, cc] = detectMSERFeatures(f, 'RegionAreaRange', [137001 158000]);
subplot(2,3,3), imshow(f);
hold on
plot(regions, 'showPixelList', true, 'showEllipses', false);
hold off;

disp(regions.Count)

fdvalues = regionprops(cc, 'Area');
disp(fdvalues(1).Area)


f = im2double(f);
% Total image area.
imarea = size(f,1)*size(f,2);
[regions, ~] = detectMSERFeatures(f, 'ThresholdDelta', 0.2);
% Show all the detected MSER regions superimposed on the image.
subplot(2,3,4), imshow(f);
hold on
plot(regions, 'showPixelList', true, 'showEllipses', false);
hold off;

disp(regions.Count)

[regions, ~] = detectMSERFeatures(f, 'ThresholdDelta', 20, ...
    'RegionAreaRange', [10000, 800000]);
subplot(2,3,5), imshow(f);
hold on
plot(regions, 'showPixelList', true, 'showEllipses', false);
hold off
disp(regions.Count)

[regions, ~] = detectMSERFeatures(f, 'ThresholdDelta', 20, ...
    'RegionAreaRange', [60000, imarea]);
subplot(2,3,6), imshow(f);
hold on
plot(regions, 'showPixelList', true, 'showEllipses', false);
hold off
disp(regions.Count)


[regions, cc] = detectMSERFeatures(f, 'ThresholdDelta', 20, 'RegionAreaRange', [14001 0.8*imarea]);
% Find the areas of all the regions.
fdvalues = regionprops(cc, 'Area');
% Extract the areas.
for k = 1:regions.Count
    area(k) = fdvalues(k).Area;
end

% Find the smallest and largest.
idx(1) = find(area == min(area(:)));
idx(2) = find(area == max(area(:)));

% Show the two resulting MSERs superimposed on the image.
for k = 1:2
    figure, imshow(f)
    hold on
    plot(regions(idx(k)), 'showPixelList', true, 'showEllipses', false);
    hold off
end
