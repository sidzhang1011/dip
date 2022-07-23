clc; clear; close all;
addpath ..;

load iris_dataset;


% (b)
% Training set
input1.X(:, 1:100) = irisInputs(:, 1:100);    % Define as class 1&2.
input1.r(1:50) = 1;
input1.r(51:100) = -1;

% Train using all the defaults.
output1 = perceptronTrain(input1);

% The algorithm converged:
disp(output1.Convergence)
disp(output1.ActualEpochs)


% (c)
input2.X(:, 1:50) = irisInputs(:, 1:50);        % Define as class 1.
input2.X(:, 51:100) = irisInputs(:, 101:150);   % Define as class 2.
input2.r(1:50) = 1;
input2.r(51:100) = -1;
input2.W = output1.W;

% Train using all the defaults.
output2 = percepclassifier(input2);

% output2
disp('output2:');
disp(output2.NumErrors);
disp(output2.Rate);
% data for setosa & verginica is seperablel


% (d)
input3.X(:, 1:50) = irisInputs(:, 51:100);        % Define as class 1.
input3.X(:, 51:100) = irisInputs(:, 101:150);   % Define as class 2.
input3.r(1:50) = 1;
input3.r(51:100) = -1;
input3.W = output1.W;

% Train using all the defaults.
output3 = percepclassifier(input3);

% output3
disp('output3:');
disp(output3.NumErrors);
disp(output3.Rate);
% 50% wrong, traing data is from setosa & versicolor, not applicable for
% versicolor & verginica.


