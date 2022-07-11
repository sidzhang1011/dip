clc; clear; close all;

fileNames = {'wingding-star-3pt.tif', 'wingding-star-5pt.tif', ...
    'wingding-star-8pt.tif'};
N = length(fileNames);
for k = 1:N
    f{k} = im2double(imread(fileNames{k}));
    if ndims(f{k}) == 3
        f{k} = rgb2gray(f{k});
    end
    subplot(3,3,k), imshow(f{k})
end

np = 20;
for k = 1:N
    temp = imgaussfilt(f{k}, 15);
    for j = 1:np
        images{j, k} = imnoise(temp, 'speckle', 0.6);
    end
    subplot(3,3,3+k), imshow(images{np, k});
end

for k = 1:N
    [NR{k}, NC{k}] = size(f{k});  
    for j=1:np
        cc = bwconncomp(imbinarize(images{j,k}));
        % Extract the largest connected region.
        numPixels = cellfun(@numel, cc.PixelIdxList);
        [biggest, idx] = max(numPixels);
        % Form a temporary image to hold the largest region.
        temp = zeros(NR{k}, NC{k});
        temp(cc.PixelIdxList{idx}) = 1;
        % Get the boundary.
        tb = bwboundaries(temp);
        b{j, k} = tb{1};
    end
    bim{k} = bound2im(b{np, k}, NR{k}, NC{k});
    subplot(3,3,6+k), imshow(bim{k});
end

for k = 1:N
    for j = 1:np
        s{j, k} = signature(b{j, k});
    end
end

for k = 1:N
    % Form a matrix whose rows are the signature vectors. Do this per
    % class.
    Xpc = [];
    for j = 1:np
        Xpc(j, :) = s{j, k}(:);
    end
    % Compute the mean vector for current class.
    [~, mv] = covmatrix(Xpc);
    M(k, :) = mv';  % Pattern vectors have to be rows of matrix M.
end

count = 0;
X = [];
for k = 1:N
    for j = 1:np
        count = count + 1;
        X(count, :) = s{j, k}(:);
    end
end

[class, ~] = minDistanceClassifier(X, M);

idx1 = find(class(1:np*3) == 1);
idx2 = find(class(1:np*3) == 2);
idx3 = find(class(1:3*np) == 3);

