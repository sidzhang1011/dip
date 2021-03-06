clc; clear; close all;

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
end

for k = 1:Nc
    rate(k) = classTrainSet(k, k)/sum(classTrainSet(k,:)) * 100;
    testrate(k) = classTestSet(k, k)/sum(classTestSet(k,:)) * 100;
end

disp('training data:')
disp(classTrainSet)
disp(rate)

disp('test data:')
disp(classTestSet)
disp(testrate)
