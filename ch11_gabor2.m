clc; clear; close all;

f = imread('national-archives-bld.png');
f = rgb2gray(f);
subplot(2,4,1), imshow(f) % Fig. 11.32(a)

% Input parameters.
wavelength = [2 8];
orientation = [0 45 90];

% Generate Gabor filter bank. There will be 6 kernels, corresponding to 
% the pairs [2 0],[8 0],[2 45],[8 45],[2 90],and [8 90].
h = gabor(wavelength,orientation);

% Obtain the magnitude of the filter response for each Gabor kernel.
gaborMag = imgaborfilt(f,h);
% Display the magnitudes of the six resulting filtered images. 
for k = 1:6
    subplot(2,4,k+1), imshow(gaborMag(:,:,k),[]) % Figs. 11.32(b),(c), and (d). 
end