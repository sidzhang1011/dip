clc; clear; close all;

f = imread('cygnusloop_Xray_original.tif');
subplot(2,3,1), imshow(f);
blocksize = [64, 32, 16, 8, 4];
for k = 1:numel(blocksize)
    g{k} = splitmerge(f, blocksize(k), @predicate);
    subplot(2,3,k+1), imshow(g{k});
end

function flag = predicate(region)
    sd = std2(region);
    m = mean2(region);
    flag = (sd > 0.0001) & (m > 0) & (m < 125);
end
