clc; clear; close all;

addpath('fcnnFunctions');
addpath('cnnFunctions');
%% READ the images, reduce them to size 32-by-32, and construct 
% the membership matrix.
I0 = [];
fileNames = {'wingding-star-3pt.tif', 'wingding-star-5pt.tif', ...
    'wingding-star-8pt.tif'};
for k = 1:length(fileNames)
    ft = im2double(imread(fileNames{k}));
    if ndims(ft) ~= 2
        ft = rgb2gray(ft);
    end

    I0(:,:,k) = mat2gray(imresize(ft, [32 32]));
end

% Number of images.
NI = size(I0, 3);

% Membership matrix for the images in I0.
R0 = [1 0 0; 0 1 0; 0 0 1];

%% Create a noisy training set.
% Create a group of images by concatenating I0 NT times. The resulting
% group will contain NT*size(I0, 3) images.

% Number of groups of images.
NT = 50;
IG = [];

% Genearate the groups of images. 
for j = 1:NT
    IG = cat(3, IG, I0);
end

% Concatenate R NT times to correspond with the number of images in IG.
R = [];
for j = 1 : NT
    R = cat(2, R, R0);
end

% Add Gaussian noise to each image in IG. This will be our training set.
% Image intensities have to be in the range [0, 1].
rng('shuffle');     % Random start seed each time.
mean = 0;
var = 0.25;
IGn = imnoise(IG, 'gaussian', mean, var);
IGn = mat2gray(IGn);

% Upsample and show one image from each class.
im1 = imresize(IGn(:, :, 1), [300 300]);
subplot(3,3,1), imshow(im1);
im2 = imresize(IGn(:, :, 2), [300 300]);
subplot(3,3,2), imshow(im2);
im3 = imresize(IGn(:, :, 3), [300 300]);
subplot(3,3,3), imshow(im3);

% Reformat the images to size M-by-M-by-depth-by-NumImages. The depth
% of these images is 1. For input into the CNN, express the images as 
% cnndatain.Images, and the membership matrix as cnndatain.R
cnndatain.Images = [];
cnndatain.Images(:,:,1,:) = IGn;
cnndatain.R = R;

%% Specify the network.
% Specify the cnn.
cnnparam.ImageSize = [32, 32, 1];
cnnparam.NumClasses = 3;
cnnparam.NumLayerKernels = [1];
cnnparam.KernelSize = [9];
cnnparam.Alpha = 1;
cnnparam.ActivationFunction = {'sigmoid'};
cnnparam.PoolType = {'average'};

% Specify the fcnn.
cnnparam.fcnnHiddenNodes = [0]; % Linear classifier
cnnparam.fcnnActivationFunction = {'sigmoid'};
cnnparam.fcnnAlpha = 1;

%% Initialize the network.
[cnn, fcnn] = cnninit(cnnparam);

%% data-specific parameters for training.
cnndatain.cnn = cnn;
cnndatain.fcnn = fcnn;
cnndatain.Epochs = 30;
cnndatain.MiniBatchSize = 3;
cnndatain.MSE = [];
cnndatain.SmoothMSE = [];

%% Train.
cnndataout = cnntrain(cnndatain);

% Plot the results.
subplot(3,3,6), plot(cnndataout.MSE, 'Color', 'm', 'linewidth', 1.0);
axis 'tight'
xlabel('(NumImages/MiniBatchSize) x (NumEpochs)')
ylabel('MSE')
ylim([0, ceil(max(cnndataout.MSE) * 10) *.1]);

subplot(3,3,9), plot(cnndataout.SmoothMSE, 'm', 'linewidth', 1.0);
axis 'tight'
xlabel('(NumImages/MiniBatchSize) x (NumEpochs)')
ylabel('Smoothed MSE')
ylim([0, ceil(max(cnndataout.MSE) * 10) *.1]);

%% Classify.
classdataout = cnnclassify(cnndataout.cnn, cnndataout.fcnn, ...
    cnndatain.Images, cnndatain.R);
disp('Performance (correct classification rate in %) of training images:')
disp(classdataout.ClassificationRate)
