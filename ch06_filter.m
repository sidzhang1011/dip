clc; close all; clear all;

rgb_image = imread('image03.jpg');
w = fspecial('average', 25);

f_rgb_filtered = imfilter(rgb_image, w, 'replicate');
fhsi = rgb2hsi(rgb_image);
fhsi_filtered = imfilter(fhsi, w, 'replicate');
fhsi_filtered_image = hsi2rgb(fhsi_filtered);
fh = fhsi(:,:,1);
fs = fhsi(:,:,2);
fi = fhsi(:,:,3);
fi_filtered = imfilter(fi, w, 'replicate');
f_image = cat(3, fh, fs, fi_filtered);
fi__filtered_image = hsi2rgb(f_image);



figure, 
subplot(2,2,1), imshow(rgb_image), title('original');
subplot(2,2,2), imshow(f_rgb_filtered), title('rgb filtered');
subplot(2,2,3), imshow(fhsi_filtered_image), title('hsi all filtered');
subplot(2,2,4), imshow(fi__filtered_image), title('intensity filtered');
