clc; clear; close all;
addpath ..;

I1 = zeros(11);
I1(5:7, 4:7) = 1;
I2 = I1';

B1 = bwboundaries(I1, 'noholes');
b1 = B1{1}; % Longest boundary.

B2 = bwboundaries(I2, 'noholes');
b2 = B2{1}; % Longest boundary.

imb1 = bound2im(b1, 11, 11);
imb2 = bound2im(b2, 11, 11);
subplot(2,4,1), imshow(imb1);
subplot(2,4,2), imshow(imb2);

c1 = freemanChainCode(b1);
c2 = freemanChainCode(b2);

% (a)
c1.mm == c2.mm;
% different, because c1 has more 0
c1.diff == c2.diff;
% different, computed by mm
c1.diffmm == c2.diffmm;
% same, c2 can be regarded as rotated c1


% (b) 
% check isCodeClosed
b1Closed = isCodeClosed(b1);
wrongb1 = [1 1; 2 2; 3 3; 1 1];
wb1Closed = isCodeClosed(wrongb1);

% (c)
% check code2coordinates
[row1, col1] = code2coordinates(c1);
[row1, col1] == b1

% (d)
% check freemanCode2Image
[fI, fB, fB0] = freemanCode2Image(c1, 2);
subplot(2,4,3), imshow(fI);

% (e)
iA = imread('letterA.tif');
subplot(2,4,4), imshow(iA);
iB = imread('letterB.tif');
subplot(2,4,5), imshow(iB);
[MA, NA] = size(iA);
[MB, NB] = size(iB);

scale = 0.2;

bA = bwboundaries(iA, 'noholes');
dA = cellfun('length', bA);
[maxdA, kA] = max(dA);
bsA = bA{kA}; % Longest boundary.
ssA = bsubsamp(bsA, scale, 8, MA, NA);
ssrA = ssA/scale;
g1 = bound2im(ssrA, MA, NA);
subplot(2,4,6), imshow(g1);



bB = bwboundaries(iB, 'noholes');
dB = cellfun('length', bB);
[maxdB, kB] = max(dB);
bsB = bB{kB}; % Longest boundary.
ssB = bsubsamp(bsB, scale, 8, MB, NB);
ssrB = ssB/scale;
g2 = bound2im(ssrB, MB, NB);
subplot(2,4,7), imshow(g2);


