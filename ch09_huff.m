% f2 = uint8([2 3 4 2; 3 2 4 4; 2 2 1 2; 1 1 2 2; 5 6 7 7; 3 7 4 7; 2 4 5 7; 4 4 3 5]);
f2 = imread("lenna.tif");
% f2 = rgb2gray(f2);
subplot(1,2,1), imshow(f2);
y = mat2huff(f2);
z = huff2mat(y);
subplot(1,2,2), imshow(z, []);