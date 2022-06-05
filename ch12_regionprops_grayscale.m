clc; clear; close all;

f = rgb2gray(imread('liver-cells-gray.png'));
subplot(2,4,1), imshow(f);

fb = imbinarize(f);
subplot(2,4,2), imshow(fb);

fs = imgaussfilt(f, 23, 'FilterSize', 139, 'Padding', 'symmetric');
subplot(2,4,3), imshow(fs), title('gauss filtered');

BW = imcomplement(imbinarize(fs));
subplot(2,4,4), imshow(BW);

fdvalues = regionprops(BW, 'all');
disp(fdvalues);

subplot(2,4,5), imshow(BW);
centroids = cat(1, fdvalues.Centroid);
hold on
plot(centroids(:,1), centroids(:,2), 'r*'), title('mark centroids');
centers = centroids;
% Estimate the diameters as the average values of the major plus the minor
% axes of the regions.
diameters = ([fdvalues.MajorAxisLength]' + [fdvalues.MinorAxisLength]')/2;
radii = diameters/2;
viscircles(centers, radii, 'Color', 'g');
hold off

fdvaluesf = regionprops(BW, f, 'PixelValues');
aver = zeros(1, length(fdvaluesf));
for k = 1:length(fdvaluesf)
    aver(k) = mean(fdvaluesf(k).PixelValues);
end
disp(aver)

CC = bwconncomp(BW);
fdvalues = regionprops(CC, 'Area', 'MajorAxisLength', 'MinorAxisLength');
idx = find([fdvalues.Area] > 1000 & [fdvalues.MinorAxisLength]./[fdvalues.MajorAxisLength] > 0.9);
BW2 = ismember(labelmatrix(CC), idx);
subplot(2,4,6), imshow(BW2);




