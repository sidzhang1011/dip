clc; clear; close all;

f = imread("lenna.tif");
c1 = im2jpeg(f);
f1 = jpeg2im(c1);
subplot(1,2,1), imshow(f1);
imratio(f, c1)
compare(f, f1, 3)


c4 = im2jpeg(f, 10);
f4 = jpeg2im(c4);
subplot(1,2,2), imshow(f4);
imratio(f, c4)
compare(f, f4, 3)
