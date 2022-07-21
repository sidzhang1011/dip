clc; clear; close all;
addpath ..;

fileNames = {'washDC-band1-blue.tif', 'washDC-band2-green.tif', ...
    'washDC-band3-red.tif', 'washDC-band4-nrinfrared.tif'};
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
    mask{k} = im2double(imread(maskNames{k}));
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
Mtrain = cat(2, mtrain{1}, mtrain{2}, mtrain{3})';


for k = 1:Nc
    d{k} = bayesgauss(trainX{k}, Ctrain, Mtrain);
    dtest{k} = bayesgauss(testX{k}, Ctrain, Mtrain);
end

for I = 1:Nc
    for J = 1:Nc
        classTrainSet(I, J) = numel(find(d{I} == J));
        classTestSet(I, J) = numel(find(dtest{I} == J));   
    end
    error{I} = 2 * find(d{I} ~= I) - 1;
end


% 14.3 (a)
mi = im2double(maskimage);
max1 = mi == max(mi(:));
mi(max1) = 0.999;
for I = 1:Nc
    errorIndex = R{I}(error{I});
    mi(errorIndex) = 1.0;
end
rgbmi = imcolorcode(mi, [0 1 0]);
subplot(3,3,6), imshow(rgbmi);


% 14.3(b)
allImages = reshape(imstack, M*N, 4);
disall = bayesgauss(allImages, Ctrain, Mtrain);
for k = 1:Nc
    newimage = zeros(M, N);
    newimage(find(disall == k)) = 1.0;
    subplot(3,3,6+k), imshow(newimage);
end


% 14.3(c) 
% besides the mask image, we don't know whether the classification
% is right or not


% 14.3(d)
imstack2 = cat(3, f{1}, f{2}, f{3});

for k = 1:Nc
    [X2{k}, R2{k}] = imstack2vectors(imstack2, mask{k});
    [ctrain2{k}, mtrain2{k}] = covmatrix(X2{k});
end

Ctrain2 = cat(3, ctrain2{1}, ctrain2{2}, ctrain2{3});
Mtrain2 = cat(2, mtrain2{1}, mtrain2{2}, mtrain2{3})';


for k = 1:Nc
    d2{k} = bayesgauss(X2{k}, Ctrain2, Mtrain2);
end

for I = 1:Nc
    for J = 1:Nc
        classTrainSet(I, J) = numel(find(d2{I} == J));
    end
end

for k = 1:Nc
    rate(k) = classTrainSet(k, k)/sum(classTrainSet(k,:)) * 100;
end
 
disp('new training data:')
disp(classTrainSet)
disp(rate)
