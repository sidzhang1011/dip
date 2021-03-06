clc; clear; close all;

f = imread('hurricane-andrew.tif');
fsize = size(f);
w = imread('hurrican-andrew-eye.tif');
wsize = size(w);
hw = zeros(fsize);
orx = fsize(1)/2 - wsize(1)/2;
ory = fsize(2)/2 - wsize(2)/2;
hw(orx:orx+wsize(1)-1, ory:ory+wsize(2)-1) = w;


subplot(2,2,1), imshow(f);
subplot(2,2,2), imshow(hw, 'InitialMagnification', 'fit');

% Compute the correlation coefficient.
g = abs(normxcorr2(w,f));
subplot(2,2,3), imshow(g, []);

% Find all the max values.
gT = g == max(g(:)); % gT is a logical array.
% Find out how many peaks there are.
idx = find(gT == 1); % we use idx again later in this example.
disp(numel(idx))

[row, col] = ind2sub(size(gT), idx);

% A single point is hard to see. Increase its size using dilation.
gT = imdilate(gT, ones(7));
subplot(2,2,4), imshow(gT);


