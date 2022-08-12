clc; clear; close all;

addpath('fcnnFunctions');
addpath('cnnFunctions');
addpath('mnist');

[I, R] = getMNISTimages(500, 'training', 1);

% Reformat the images to size M-by-M-by-depth-by-NumImages. The depth
% of these images is 1. For input into the CNN, express the images as 
% cnndatain.Images, and the membership matrix as cnndatain.R
cnndatain.Images = I;
cnndatain.R = R;

%% Specify the network.
% Specify the cnn.
cnnparam.ImageSize = [28, 28, 1];
cnnparam.NumClasses = 10;
cnnparam.NumLayerKernels = [6 12];
cnnparam.KernelSize = [5 5];
cnnparam.Alpha = 0.1;
cnnparam.ActivationFunction = {'sigmoid'};
cnnparam.PoolType = {'average'};

% Specify the fcnn.
cnnparam.fcnnHiddenNodes = [0]; % Linear classifier
cnnparam.fcnnActivationFunction = {'sigmoid'};
cnnparam.fcnnAlpha = 0.05;

%% Initialize the network.
[cnn, fcnn] = cnninit(cnnparam);

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
[I1, R1] = getMNISTimages(1000, 'test', 'random');
classificationTest = cnnclassify(cnndataout.cnn, cnndataout.fcnn, I1, R1);
disp('Classification rate on test image')
disp(classificationTest.ClassificationRate)
