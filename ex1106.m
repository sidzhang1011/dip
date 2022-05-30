clear; clc; close all;
f1 = imread('spot_shaded_text_image.tif');
f2 = imread('sine_shaded_text_image.tif');
subplot(2,4,1), imshow(f1);

% (a)
T1a = adaptthresh(f1, 0.8);
g1a = imbinarize(f1, T1a);
subplot(2,4,2), imshow(f2);

% (b)
% c1 = checkerboard(1024);
% subplot(2,2,3), imshow(c1);

% (c)
data = localmean(f1, ones(3));

% td = [1 2 3 4; 5 6 7 8; 9 10 11 12];
% d text 
gm = movingaveragethresh(f1, 20, 0.5);
subplot(2,4,3), imshow(gm);

% e text-sineshade.tif
gm2 = movingaveragethresh(f2, 20, 0.5);
subplot(2,4,4 ), imshow(gm2);

% jelly
f = im2double(imread('yeast_cells.tif'));
subplot(2,4,5), imshow(f);

Ta = adaptthresh(f, 0.58, 'Neigh', 9, ...
     'Stat','gaussian', 'Fore','bright');
ga = imbinarize(f, Ta);
subplot(2,4,6), imshow(ga), title('adapthresh');

gm2 = movingaveragethresh(f, 20, 0.9);
subplot(2,4, 7), imshow(gm2), title('moving average');

nhood = ones(3,3);
gm3 = adaptthresh2(f, nhood, 35, 1.011, 'all');
subplot(2,4, 8), imshow(gm3), title('based on local');
