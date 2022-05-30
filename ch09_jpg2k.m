clc; clear; close all;

f = imread("lenna.tif");
c1 = im2jpeg2k(f, 5, [8 8.5]);
f1 = jpeg2k2im(c1);

subplot(1,2,1), imshow(f1);
rms1 = compare(f, f1, 2)

cr1 = imratio(f, c1)

c2 = im2jpeg2k(f, 5, [8 7]);
f2 = jpeg2k2im(c2);

subplot(1,2,2), imshow(f2);
rms2 = compare(f, f2, 2)

cr2 = imratio(f, c2)