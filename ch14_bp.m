clc; clear; close all;

fileNames = {'washDC-band1-blue.tif', 'washDC-band2-green.tif', ...
    'washDC-band3-red.tif', 'washDC-band4-nrinfrared.tif'};
for k = 1: length(fileNames)
    f{k} = im2double(imread(fileNames{k}));
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

% maskimage = mask{1} | mask{2} | mask{3};
% subplot(3,3,5), imshow(maskimage);

imstack = cat(3, f{1}, f{2}, f{3}, f{4});

% Extract training and test pattern sets.
for k = 1:Nc
    [X{k}, ~] = imstack2vectors(imstack, mask{k});
    % Training patterns.
    trainX{k} = X{k}(1:2:end, :)';
    % Number training patterns for each class.
    ntrain{k} = size(trainX{k}, 2);
    % Test patterns.
    testX{k} = X{k}(2:2:end, :)';
    % Number test patterns for each class.
    ntest{k} = size(testX{k}, 2);
end

% Number of training and test patterns.
nptrain = sum([ntrain{:}]);
nptest = sum([ntest{:}]);

% Form the pattern matrices.
% Training patterns.
Xtrain = cat(2, trainX{1}, trainX{2}, trainX{3});
nptrain = size(Xtrain, 2); % Number of patterns.
% Test patterns.
Xtest = cat(2, testX{1}, testX{2}, testX{3});
nptest = size(Xtest, 2); % Number of patterns.

% Construct membership matrices.
% Training patterns.
Rtrain = zeros(Nc, nptrain);
Rtrain(1, 1:ntrain{1}) = 1;
Rtrain(2, ntrain{1}+1:ntrain{1}+ntrain{2}) = 1;
Rtrain(3, ntrain{1}+ntrain{2}+1:ntrain{1}+ntrain{2}+ntrain{3}) = 1;

% Test patterns.
Rtest = zeros(Nc, nptest);
Rtest(1, 1:ntest{1}) = 1;
Rtest(2, ntest{1} + 1: ntest{1} + ntest{2}) = 1;
Rtest(3, ntest{1} + ntest{2} + 1: ntest{1} + ntest{2} + ntest{3}) = 1;


fcnnparam.NumNodes = [4 3 3];
fcnnparam.ActivationFunction = {'sigmoid'};
fcnnparam.Alpha = 0.001;

% Initialize the network.
fcnn = fcnninit(fcnnparam);
fcnndatain.X = Xtrain;
fcnndatain.R = Rtrain;
fcnndatain.Epochs = 1000;
% Use batch training.
fcnndatain.MiniBatchSize = size(fcnndatain.X, 2);  % Num of training 
% patterns.

% Train the network.
[fcnn, fcnndataout] = fcnntrain(fcnn, fcnndatain);

% plot the mean squared error.
subplot(2,2,1), plot(fcnndataout.MSE);


% Compute the classification rate using the weights learned in 5000 epochs.
fcnndatain.X = Xtest;
fcnndatain.R = Rtest;
classifieroutput = fcnnclassify(fcnn, fcnndatain.X, fcnndatain.R);
disp(classifieroutput.ClassificationRate)
