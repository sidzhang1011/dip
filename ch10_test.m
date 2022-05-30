f = imread('Figp0917.tif');
se = strel('dis', 11, 0);       % Structuring element.
fa = imerode(f, se);
fb = imdilate(fa, se);
fc = imdilate(fb, se);
fd = imerode(fc, se);

subplot(2,2,1), imshow(fa);
subplot(2,2,2), imshow(fb);
subplot(2,2,3), imshow(fc);
subplot(2,2,4), imshow(fd);