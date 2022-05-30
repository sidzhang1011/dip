clc; close all; clear;

f = imread('defective_weld.tif');
subplot(2,2,1), imshow(f);

[g, NR, SI, TI] = regiongrow(f, 1, 0.26);
subplot(2,2,2), imshow(SI), title('SI');
subplot(2,2,3), imshow(g), title('g');
subplot(2,2,4), imshow(TI), title('TI');