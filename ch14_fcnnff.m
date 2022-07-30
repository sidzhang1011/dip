clc; clear; close all;
addpath('fcnnFunctions');

fcnnparams.NumNodes = [3 2 2]; 
% The values of the following two fields are defaults,
% but we specify them for instructional purposes.
fcnnparams.ActivationFunction = {'sigmoid'};
fcnnparams.Alpha = 1.0;

% Initialize.
fcnn = fcnninit(fcnnparams);

% The weights and biases output by function fcnninit are random. They are
% used to initialize the FCNN for training. In this example, we know the
% weights and biases.
fcnn(2).Weights = [0.1 0.2 0.6; 0.4 0.3 -0.1];
fcnn(2).Biases = [0.40, -0.20]';
fcnn(3).Weights = [-0.2 -0.1; 0.1 0.4];
fcnn(3).Biases = [0.6, 0.3]';
X = [1 -1; 1 -1; 1 -1];
fcnn = fcnnff(fcnn, X);
disp(fcnn)