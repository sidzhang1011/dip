clc; clear; close all;
addpath ..;

fileNames = {'wingding-star-3pt.tif', 'wingding-star-5pt.tif', ...
    'wingding-star-8pt.tif'};
N = length(fileNames);
rotateTimes = 8;
af = cell(24);
for k = 1:N
    f{k} = im2double(imread(fileNames{k}));
    if ndims(f{k}) == 3
        f{k} = rgb2gray(f{k});
    end    
    for j = 1:rotateTimes
        num = 8*(k-1) + j;
        af{num} = imrotate(f{k}, 45*(j-1), 'crop') ;
        subplot(9,8,num), imshow(af{num});
    end
end

np = 20;
imageNum = N*rotateTimes;
for k = 1:imageNum
    temp = imgaussfilt(af{k}, 15);
    for j = 1:np
        images{j, k} = imnoise(temp, 'speckle', 0.6);
        testimages{j, k} = imnoise(temp, 'speckle', 0.6);
    end
    subplot(9,8,24+k), imshow(images{np, k});
end

for k = 1:imageNum
    [NR{k}, NC{k}] = size(af{k});  
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
    subplot(9,8,48+k), imshow(bim{k});
end

for k = 1:imageNum
    for j = 1:np
        s{j, k} = signature(b{j, k});
    end
end

for k = 1:imageNum
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
for k = 1:imageNum
    for j = 1:np
        count = count + 1;
        X(count, :) = s{j, k}(:);
    end
end

[class, ~] = minDistanceClassifier(X, M);

trainingrate = zeros(1, imageNum + 1);
correctNum = 0;
for k = 1:imageNum
    cn = sum(class(1+(k-1)*np: np*k) == k);
    trainingrate(k) = cn/np;
    correctNum = correctNum + cn;
end
trainingrate(imageNum + 1) = correctNum/count;
disp(trainingrate)

