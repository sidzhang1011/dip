f = imread('house.bmp');
f = tofloat(f);
F = fft2(f);
S = fftshift(log(1 + abs(F)));
imshow(S, []);

h = fspecial('sobel');
PQ = paddedsize(size(f));
H = freqz2(h, PQ(1), PQ(2));
H1 = ifftshift(H);
gs = imfilter(f, h);
gf = dftfilt(f, H1);