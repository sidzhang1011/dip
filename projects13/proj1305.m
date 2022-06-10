clc; clear; close all;
addpath ..;

% (a). based on Freeman chain codes for differentiating
imageFiles = ['letterA.tif'; 'letterB.tif'; 'letterC.tif'];
count = size(imageFiles, 1);

images = cell(count, 1);
stats = cell(count, 1);
BW = cell(count, 1);
for i = 1:count
    images{i} = imread(imageFiles(i,:));
    BW{i} = images{i} > 0;
    stats{i} = regionprops(BW{i}, 'all');
end

% A: 
% Eccentricity: 0.6105
% Circularity: 0.2021
% EulerNumber: 0
% Solidity: 0.5033

% B:
% Eccentricity: 0.7274
% Circularity: 0.3516
% EulerNumber: -1
% Solidity: 0.4662

% C:
% Eccentricity: 0.5557
% Circularity: 0.1380
% EulerNumber: 1
% Solidity: 0.3335

% the best way is use EulerNumber, Circularity is also OK.
% FilledArea is another alternative.


% (b)
% add noise
% use filter and dilate to solve problem
se = strel('square', 3); 
for i = 1:count
    images{i} = imnoise(images{i}, 'Gaussian', 0, 0.03);
    images{i} = imgaussfilt(images{i});
    subplot(2,3,i), imshow(images{i});
    BW{i} = images{i} > 0.2*255;
    BW{i} = imopen(BW{i}, se);
    subplot(2,3,3+i), imshow(BW{i});
    stats{i} = regionprops(BW{i}, 'all');
end
% according to experiment, EulerNumber still same, Circularity very near to
% the orginal value

