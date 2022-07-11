clc; clear; close all;

fileNames = {'washDC_band1_blue.tif', 'washDC_band2_green.tif', ...
    'washDC_band3_red.tif', 'washDC_band4_nrinfrared.tif'};
for k = 1: length(fileNames)
    f{k} = im2double(imread(fileNames{k}));
    subplot(3,3,k), imshow(f{k});
end
[M, N] = size(f{1});

% Three classes: class 1 = water, class 2 = urban development, and class 3
% = vegetation.
Nc = 3;
maskNames = {'washDC-mask-water.tif', 'washDC-mask-urban.tif', ...
    'washDC-mask-veg.tif'};
for k = 1:length(maskNames)
    bgmask = zeros(M, N);
    fi = im2double(imread(maskNames{k}));
    [mr, mc] = size(fi);
    bgmask((M-mr)/2:(M+mr)/2 -1, (N-mc)/2:(N+mc)/2 -1) = fi;
    mask{k} = bgmask;
end
maskimage = mask{1} | mask{2} | mask{3};
subplot(3,3,5), imshow(maskimage);

imstack = cat(3, f{1}, f{2}, f{3}, f{4});

for k = 1:Nc
    [X{k}, R{k}] = imstack2vectors(imstack, mask{k});
    trainX{k} = X{k}(1:2:end, :);
    trainR{k} = R{k}(1:2:end, :);
    testX{k} = X{k}(2:2:end, :);
    testR{k} = R{k}(2:2:end, :);
    [ctrain{k}, mtrain{k}] = covmatrix(trainX{k});
end

Ctrain = cat(3, ctrain{1}, ctrain{2}, ctrain{3});
Mtrain = cat(3, mtrain{1}, mtrain{2}, mtrain{3});
Mtrain = reshape(Mtrain, Nc, numel(mtrain{1}));

for k = 1:Nc
    d{k} = bayesgauss(trainX{k}, Ctrain, Mtrain);
end

for I = 1:Nc
    for J = 1:Nc
        classTrainSet(I, J) = numel(find(d{I} == J));
    end
end

disp(classTrainSet)

for k = 1:Nc
    rate(k) = classTrainSet(k, k)/sum(classTrainSet(k,:)) * 100;
end

disp(rate)
