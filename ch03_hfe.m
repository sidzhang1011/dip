clc; clear all; close all;

f = imread('darkchest.png');
f = rgb2gray(f);
[f, revertclass] = tofloat(f);
PQ = paddedsize(size(f));
[U,V] = dftuv(PQ(1), PQ(2));
D = hypot(U,V);
D0 = 0.05 * PQ(1);
HBW = hpfilter('btw', PQ(1), PQ(2), D0, 2);
Hlp = lpfilter('btw', PQ(1), PQ(2), D0, 2);
H = 0.8 + 0.4*HBW;
gbw = dftfilt(f, HBW, 'fltpoint');
gbw = gscale(gbw);
ghf = dftfilt(f, H, 'fltpoint');
ghf = gscale(ghf);
ghe = histeq(ghf, 256);

Hlp = 3*Hlp + HBW;
glp = dftfilt(f, Hlp);
glp = gscale(glp);
gle = histeq(glp, 256);

subplot(2,3,1); imshow(f, []); title('original image');
subplot(2,3,2); imshow(gbw, [0 256]); title('hp filtered image');
subplot(2,3,3); imshow(ghf, [0 256]); title('high freq emphasis image');
subplot(2,3,4); imshow(ghe, []); title('high freq emphasis and histeq image');
subplot(2,3,5); imshow(glp);
subplot(2,3,6); imshow(gle);
