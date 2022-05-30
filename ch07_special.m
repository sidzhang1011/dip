close all; clear all;

f = imread('image03.jpg');
f = rgb2gray(f);
[c,s] = wavefast(f, 4, 'jpeg9.7');
wavedisplay(c, s, 8);

f1 = wavecopy('a', c, s);
figure;
subplot(231); imshow(mat2gray(f1));

[c, s] = waveback(c, s, 'jpeg9.7', 1);
f2 = wavecopy('a', c, s);
subplot(232); imshow(mat2gray(f2));

[c, s] = waveback(c, s, 'jpeg9.7', 1);
f3 = wavecopy('a', c, s);
subplot(233); imshow(mat2gray(f3));

[c, s] = waveback(c, s, 'jpeg9.7', 1);
f4 = wavecopy('a', c, s);
subplot(234); imshow(mat2gray(f4));

[c, s] = waveback(c, s, 'jpeg9.7', 1);
f5 = wavecopy('a', c, s);
subplot(235); imshow(mat2gray(f5));
