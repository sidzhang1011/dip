clc; close all; clear;

f = imread('chromosome-noisy.tif');
f = rgb2gray(f);
subplot(1,4,1), imshow(f);

% Smooth the image.
fs = imgaussfilt(f, 11, 'FilterSize', 67);
subplot(1,4,2), imshow(fs);

% Threshold it using function imbinarize.
BW = imbinarize(fs);
subplot(1,4,3), imshow(BW);

S = bwskel(BW);
subplot(1,4,4), imshow(S);