i = imread('trees.tif', 1);
frames = size(imfinfo('trees.tif'), 1);
s1 = uint8(zeros([size(i) 1 2]));
s1(:, :, :, 1) = i;
s1(:, :, :, 2) = imread('trees.tif', frames);
size(s1)
lut = 0:1/255:1;
lut = [lut' lut' lut'];

m1(1) = im2frame(s1(:,:,:,1), lut);
m1(2) = im2frame(s1(:,:,:,2),lut);

m = tifs2mov('trees.tif');
implay(m);