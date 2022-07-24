clc; clear; close all;
addpath ..;


% （c) 
load iris_dataset;
% input1.X(:, 1:100) = irisInputs(:, 1:100);
% input1.r(1:50) = 1.0;
% input1.r(51:100) = -1.0;

input1.X(:, 1:30) = irisInputs(:, 1:30);
input1.X(:, 31:60) = irisInputs(:, 51:80);

input1.r(1:30) = 1.0;
input1.r(31:60) = -1.0;

[input1.X, input1.r, order] = patternShuffle(input1.X, input1.r, 'repeat');
input1.Alpha = 0.001;
input1.MSEDelta = 0.01;
input1.W0 = zeros(1, 5);
% input1.NumEpochs = 1000;

output1 = lmsePerceptronTrain(input1);

disp(output1.MSE);
disp(output1)

row = 1:numel(output1.MSE);
figure;
plot(row, output1.MSE);

input2.W = output1.W;
input2.X(:, 1:20) = irisInputs(:, 31:50);
input2.X(:, 21:40) = irisInputs(:, 81:100);

input2.r(1:20) = 1.0;
input2.r(21:40) = -1.0;

output2 = perceptronClassify(input2);
disp(output2.NumErrors);
disp(output2.Rate);


% （d) 
input3.X(:, 1:30) = irisInputs(:, 51:80);
input3.X(:, 31:60) = irisInputs(:, 101:130);

input3.r(1:30) = 1.0;
input3.r(31:60) = -1.0;

[input3.X, input3.r, order] = patternShuffle(input3.X, input3.r, 'repeat');
input3.Alpha = 0.001;
input3.MSEDelta = 0.01;
input3.W0 = zeros(1, 5);
input3.NumEpochs = 1000;

output3 = lmsePerceptronTrain(input3);

disp(output3.MSE);
disp(output3)

row = 1:numel(output3.MSE);
figure,
plot(row, output3.MSE);

input4.W = output3.W;
input4.X(:, 1:20) = irisInputs(:, 81:100);
input4.X(:, 21:40) = irisInputs(:, 131:150);

input4.r(1:20) = 1.0;
input4.r(21:40) = -1.0;

output4 = perceptronClassify(input4);
disp(output4.NumErrors);
disp(output4.Rate);
