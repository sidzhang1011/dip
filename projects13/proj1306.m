clc; close all; clear;
addpath ..;

imageFiles = {  'superconductor-smooth-texture.tif'; ...
                'cholesterol-rough-texture.tif'; ...
                'microporcessor-regular-texture.tif'};
count = size(imageFiles, 1);
images = cell(count, 1);

specs = cell(count, 1);
specs{1}.Coordinates = [80, 200];
specs{2}.Coordinates = [70, 120];
specs{3}.Coordinates = [15, 13];

subImages = cell(count, 1);
for i=1:count
    specs{i}.Height = 60;
    specs{i}.Width = 60;
    specs{i}.LineColor = 'm';

    images{i} = imread(imageFiles{i});
    subplot(2,3,i), imshow(images{i});
    hold on
    subImages{i} = imrectangle(images{i}, specs{i});
    hold off
end

stats = cell(count, 1);
for i = 1:count
    stats{i} = statxture(subImages{i});
    subplot(2,3,3+i), imhist(subImages{i});
end

disp(['Av_gray_level A_contrast smoothness ' ...
    '3rd_moment uniformity Entropy']);
disp(stats)
% smoothness: the smaller of the value, the more smooth
