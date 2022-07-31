clc; clear; close all;
addpath('../fcnnFunctions');


% (a)
load iris_dataset;

% train data
xtrain = zeros(4, 90);
xtrain(:,1:30) = irisInputs(:, 1:30);
xtrain(:,31:60) = irisInputs(:, 51:80);
xtrain(:,61:90) = irisInputs(:, 101:130); 
rtrain = zeros(3, 90);
rtrain(1, 1:30) = 1;
rtrain(2, 31:60) = 1;
rtrain(3, 61:90) = 1;

% teast data
xtest = zeros(4, 60);
xtest(:,1:20) = irisInputs(:, 31:50);
xtest(:,21:40) = irisInputs(:, 81:100);
xtest(:,41:60) = irisInputs(:, 131:150); 
rtest = zeros(3, 60);
rtest(1, 1:20) = 1;
rtest(2, 21:40) = 1;
rtest(3, 41:60) = 1;


% (b).
fcnnparam.NumNodes = [4 3 3 3];
fcnnparam.ActivationFunction = {'tanh'};
fcnnparam.Alpha = 0.001;
fcnn = fcnninit(fcnnparam);
for I = 1:20
    fcnndatain.X = xtrain;
    fcnndatain.R = rtrain;
    fcnndatain.Epochs = 2000;
    [fcnn, fcnndataout] = fcnntrain(fcnn, fcnndatain);
    MSE = fcnndataout.MSE;
    if MSE <= 5
        break
    end
end



% (c)
subplot(2,2, 1), plot(fcnndataout.MSE);


% (d)
classifieroutput = fcnnclassify(fcnn, fcnndatain.X, fcnndatain.R);
disp(classifieroutput.ClassificationRate)


% (e)
classifieroutput = fcnnclassify(fcnn, xtest, rtest);
disp(classifieroutput.ClassificationRate)


