clc; clear; close all;

f = imread("lenna.tif");
q  = uint8(quantize(f, 4, 'igs'));
qs = double(q)/16;
e = mat2lpc(qs);
c = mat2huff(e);
imratio(f, c);
% subplot(1,2,1), imshow(mat2gray(e));
% ntrop(e)
% subplot(1,2,2), imshow(z, []);
ne = huff2mat(c);
nqs = lpc2mat(ne);
nq = uint8(16*nqs);

% compare(double(q), double(nq))

compare(f, nq)