clc; clear all; close all;

f = imread('moirecar.png');
% f = rgb2gray(f);
[f, revertclass] = tofloat(f);
PQ = paddedsize(size(f));
F = fft2(f, PQ(1), PQ(2));
S = gscale(log(1 + abs(fftshift(F)))); % spectrum


[U,V] = dftuv(PQ(1), PQ(2));
D = hypot(U,V);

[M N] = size(f);

% Use function imtool to obtain the coordinates of the spike interactively.
C1 = [168, 111; 168, 226; 330,111; 330,226];
% C1 = [168, 111; 168, 226];

% Notch filter
H1 = cnotch('gaussian', 'reject', PQ(1), PQ(2), C1, 5);
%Compute spectrum of the filtered transform and show it as an image
P1 = gscale(fftshift(H1).*(tofloat(S)));

% filter image.
g1 = dftfilt(f, H1);
g1 = revertclass(g1);



% Use function imtool to obtain the coordinates of the spike interactively.
C2 = [168, 111; 168, 226; 330,111; 330,226; 87,108;  412,112];
% C2 = [168, 111; 168, 226];

% Notch filter
H2 = cnotch('gaussian', 'reject', PQ(1), PQ(2), C2, 5);
%Compute spectrum of the filtered transform and show it as an image
P2 = gscale(fftshift(H2).*(tofloat(S)));

% filter image.
g2 = dftfilt(f, H2);
g2 = revertclass(g2);

gd = abs(g1 - g2);


subplot(2,3,1); imshow(f, []); title('original image');
subplot(2,3,2); imshow(S, [0 255]); title('F frequency spectrum');
subplot(2,3,3); imshow(P1, []); title('notch filter spectrum');
subplot(2,3,4); imshow(g1, [0 255]); title('filtered image');
subplot(2,3,5); imshow(P2, []); title('notch filter spectrum');
subplot(2,3,6); imshow(g2, [0 255]); title('filtered image');

H = recnotch('reject', 'both', 500, 500, 3, 15, 15);
imshow(fftshift(H), []);
