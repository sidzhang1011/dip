clear; close all; clc;

% example 1
input.X = [1 1; 3 3]';
input.r = [-1 1]';
input.W0 = [0.1, 0, 0]';
input.Alpha = 1.0;
output = perceptronTrain(input);
disp(output.W)
disp(output.Convergence)
disp(output.ActualEpochs)


% example 2 
% iris
load iris_dataset

disp('iris data:')
% Training set
inputT.X(:,1:30) = irisInputs(:, 1:30);     % Define as class 1.
inputT.X(:, 31:60) = irisInputs(:, 51:80);  % Define as class 2.
inputT.r(1:30) = 1;
inputT.r(31:60) = -1;

% Train using all the defaults.
outputT = perceptronTrain(inputT);

% The algorithm converged:
disp(outputT.Convergence)

% It took only 5 epochs to converge, an indication that the separation
% between classes is large.
disp(outputT.ActualEpochs)

inputC.X(:, 1:20) = irisInputs(:, 31:50);
inputC.X(:, 21:40) = irisInputs(:, 81:100);
inputC.W = outputT.W;
% Provide the class memebership so that we can determine the accuracy of
% classifcation of the test set.
inputC.r(1:20) = 1;
inputC.r(21:40) = -1;

% Classify.
outputC = perceptronClassify(inputC);
% There were no errors in classification.
disp(outputC.NumErrors)

% So, the correct classification rate is 100%.
disp(outputC.Rate)