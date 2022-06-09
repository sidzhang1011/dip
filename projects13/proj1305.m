clc; clear; close all;
addpath ..;

% (a). based on Freeman chain codes for differentiating
imageFiles = ['letterA.tif'; 'letterB.tif'; 'letterC.tif'];
count = size(imageFiles, 1);

images = cell(count);
by = cell(count,1);
for i = 1:count
    images{i} = imread(imageFiles(i,:));
    bwb = bwboundaries(images{i});
    ad = cellfun('length', bwb);
    [maxdA, kA] = max(ad);
    by{i} = bwb{kA}; % Longest boundary.
end