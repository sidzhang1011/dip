clc; close all; clear all;

[phi, psi, xval] = wavefun('haar', 10);
xaxis = zeros(size(xval));
subplot(121); plot(xval, phi, 'r', xval, xaxis, '--k');
axis([0 1 -1.5 1.5]); axis square;
title('Haar Scaling Function');
subplot(122); plot(xval, psi, 'k', xval, xaxis, '--k');
axis([0 1 -1.5 1.5]); axis square;
title('Haar Wavelet Function');

f = magic(4);
[c1, s1] = wavedec2(f, 1, 'haar');
