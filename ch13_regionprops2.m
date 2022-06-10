clc; clear; close all;

I = imread('UTK.tif'); % Using > 0 sets the image to logical.
I = rgb2gray(I);
CC = bwconncomp(I);

% Display the number of regions found.
disp(CC.NumObjects)

L = labelmatrix(CC);
% There are three regions, so the nonzero elements of L are 1, 2, and 3.

% Obtain all three regions.
fdvalues = regionprops(L, 'SubarrayIdx');

% Display the second region as an image.
im2 = L(fdvalues(3).SubarrayIdx{:});
% The values of im2 are 0 and one of the values from L, so convert them to
% floating-point values in the range [0,1].
im2 = intensityScaling(im2);

% Display the image. In this case, the image is the same as ...
% It's size is the same as the region's bounding box.
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(im2);

BW = I > 0;
% Compute the convex hull.
fdvalues1 = regionprops(BW, 'ConvexImage');
% The size of the image will be the same as the bounding box of the region
% in BW, so that size will be compatible with the size of the convex hull
% computation.
fdvalues2 = regionprops(BW, 'Image');
% Apply the definition of the convex deficiency.
convexDeficiency = fdvalues1(1).ConvexImage & ~fdvalues2(1).Image;
