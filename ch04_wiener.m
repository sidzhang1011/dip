clc; clear all; close all;

f = checkerboard(8);    % > 0.5;
PSF = fspecial('motion', 7, 45);
gb = imfilter(f, PSF, 'circular');
noise = imnoise2('Gaussian', size(f,1), size(f,2), 0, sqrt(0.001));
g = gb + noise;

% inverse filtering
frest1 = deconvwnr(g, PSF);

% Compute constant R
Sn = abs(fft2(noise)).^2;               % noise power spectrum
nA = sum(Sn(:))/numel(noise);           % noise average power;
Sf = abs(fft2(f)) .^ 2;                 % image power spectrum
fA = sum(Sf(:))/numel(f);               % image average power.
R = nA/fA;
frest2 = deconvwnr(g, PSF, R);

% Compute SNR per point
NCORR = fftshift(real(ifft2(Sn)));
ICORR = fftshift(real(ifft2(Sf)));
frest3 = deconvwnr(g, PSF, NCORR, ICORR);

% Constrained least squares
frest4 = deconvreg(g, PSF, 4);

% Constrained least squares
frest5 = deconvreg(g, PSF, 0.4, [1e-7 1e7]);

subplot(2,3,1); imshow(g, []); title('motion and gaussian noised image');
subplot(2,3,2); imshow(frest1, []); title('direct inverse image');
subplot(2,3,3); imshow(frest2, []); title('Wiener const filtering image');
subplot(2,3,4); imshow(frest3, []); title('Wiener SNR filtered image');
subplot(2,3,5); imshow(frest4, []); title('Constrained least squares filtered image');
subplot(2,3,6); imshow(frest5, []); title('Constrained least squares filtered image 2');

