clc; clear; close all;

addpath('fcnnFunctions');
addpath('cnnFunctions');
addpath('cifar-10-batches-mat');


%% Specify the network.
% Specify the cnn.
cnnparam.ImageSize = [32, 32, 3];
cnnparam.NumClasses = 10;
cnnparam.NumLayerKernels = [6 12];
cnnparam.KernelSize = [5 5];
cnnparam.Alpha = 1;
cnnparam.ActivationFunction = {'sigmoid'};
cnnparam.PoolType = {'average'};

% Specify the fcnn.
cnnparam.fcnnHiddenNodes = [0]; % Linear classifier
cnnparam.fcnnActivationFunction = {'sigmoid'};
cnnparam.fcnnAlpha = 0.01;

%% Initialize the network.
[cnn, fcnn] = cnninit(cnnparam);

[cnndatain.Images, cnndatain.R] = getCIFAR10images([], 'training');
%% data-specific parameters for training.
cnndatain.cnn = cnn;
cnndatain.fcnn = fcnn;
cnndatain.Epochs = 50;
cnndatain.MiniBatchSize = 50;
cnndatain.MSE = [];
cnndatain.SmoothMSE = [];

%% Train.
cnndataout = cnntrain(cnndatain);

% Plot the results.
subplot(2,2,1), plot(cnndataout.MSE, 'Color', 'm', 'linewidth', 1.0);
axis 'tight'
xlabel('(NumImages/MiniBatchSize) x (NumEpochs)')
ylabel('MSE')
ylim([0, ceil(max(cnndataout.MSE) * 10) *.1]);

subplot(2,2,2), plot(cnndataout.SmoothMSE, 'm', 'linewidth', 1.0);
axis 'tight'
xlabel('(NumImages/MiniBatchSize) x (NumEpochs)')
ylabel('Smoothed MSE')
ylim([0, ceil(max(cnndataout.MSE) * 10) *.1]);

%% Classify.
classdataout = cnnclassify(cnndataout.cnn, cnndataout.fcnn, ...
    cnndatain.Images, cnndatain.R);
disp('Correct classification rate in % of training images:')
disp(classdataout.ClassificationRate)

%% Generate a test of 1000 random test images and test the cnn/fcnn.
% [I1, R1] = getMNISTimages(1000, 'test', 'random');
% classificationTest = cnnclassify(cnndataout.cnn, cnndataout.fcnn, I1, R1);
% disp('Classification rate on test image')
% disp(classificationTest.ClassificationRate)
