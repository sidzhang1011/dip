clc; clear; close all;

f = imread('mapleleaf.tif');
% f = rgb2gray(f);
w = fspecial('average', 9);
f = imfilter(f, w, 'replicate');
subplot(2,4,1), imshow(f);

% Obtain the boundary and display it a an image
B = bwboundaries(f);
b = B{1}; % There is only one boundary in this case. 
disp(length(b))
bim = bound2im(b, size(f,1), size(f,2));
subplot(2,4,2), imshow(bim, []);

% Compute the Fourier descriptors. The number of descriptors is equal to
% the number of points on the boundary
if(length(b)/2 ~= round(length(b)/2))
    b = cat(1, b, b(1, :));
end
z = frdescp(b);

% Obtain the inverse using half of the Fourier descriptors, making sure it
% is an even number:
nd = length(z)/2 + rem(length(z)/2, 2);
shalf = ifrdescp(z, nd);
% convert to an image and display.
shalfim = bound2im(shalf, size(f,1), size(f,2));
subplot(2,4,3), imshow(shalfim);

for i = 1:6
    di = pow2(i+1);
    t = uint16(length(z)/di);
    nd1 =  t + rem(t, 2);

    shalf1 = ifrdescp(z, nd1);
    % convert to an image and display.
    shalfim1 = bound2im(shalf1, size(f,1), size(f,2));
    subplot(2,4,i+2), imshow(shalfim1);
end

