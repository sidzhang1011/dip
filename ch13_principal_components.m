clc; clear; close all;

FileNames = {'washDC_band1_blue.tif', 'washDC_band2_green.tif',
    'washDC_band3_red.tif', 'washDC_band4_nrinfrared.tif',
    'washDC_band5_mdlinfrared.tif', 'washDC_band6_thmalinfrared.tif'};

for k = 1:numel(FileNames)
    f{k} = imread(FileNames{k});
end
% figure, montage(f, 'Size', [2 3]);

% Form image stack.
S = [];
for k=1:numel(FileNames)
    S = cat(3, S, f{k});
end

% Form X.
X = imstack2vectors(S);

% Get all six principal component images.
P = principalComponents(X, 6);

% Scale the images and display the images as a 2x3 montage.
for k = 1:numel(FileNames)
    g{k} = P.Y(:, k);
    g{k} = intensityScaling(reshape(g{k}, 564, 564));
end

% Instead of montage, we could have used function imtile mentioned in ch2.
figure, montage(g, 'Size', [2 3]);


% Eigenvalues.
evalues = diag(P.Cy);
format shortG
disp(round(evalues));

% Reconstruct the images using only the principal component images
% corresponding to the two largest eigenvalues.
PR = principalComponents(X, 3);

% Display the reconstructed images as a 2x3 montage.
for k = 1:numel(FileNames)
    gR{k} = PR.X(:, k);
    gR{k} = intensityScaling(reshape(gR{k}, 564, 564));
end
figure, montage(gR, 'Size', [2 3]);

% Differences between originals and reconstructed.
for k = 1:numel(FileNames)
     diff{k} = imsubtract(im2double(f{k}), gR{k});
%     diff{k} = imsubtract(g{k}, gR{k});
end

% Compute the maximum differences. Each value of maxdiff below is a scalar.
for k = 1 : numel(FileNames)
    maxdiff(k) = max(diff{k}(:));
end
% Display the maximum value of the six maxima:
disp(max(maxdiff(:)))

% Display the image that gave the maximum difference.
idx = find(maxdiff == max(maxdiff(:)));
figure, subplot(1,2,1), imshow(diff{idx(1)});

% Scale the difference image to see the intensity differences.
diffscaled = intensityScaling(diff{idx});
subplot(1,2,2), imshow(diffscaled)
