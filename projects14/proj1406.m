clc; clear; close all;
addpath('../fcnnFunctions');

% (a)
fcnnparam.NumNodes = [2 2 2];
fcnnparam.ActivationFunction = {'sigmoid'};
fcnnparam.Alpha = 1;

fcnn = fcnninit(fcnnparam);

X = [-1 1 -1 1; -1 1 1 -1];
R = [1 1 0 0; 0 0 1 1];
fcnndatain.X = X;
fcnndatain.R = R;
fcnndatain.Epochs = 1000;

% Train the network.
[fcnn, fcnndataout] = fcnntrain(fcnn, fcnndatain);


% (b)
% plot the mean squared error.
subplot(2,2,1), plot(fcnndataout.MSE);

classifieroutput = fcnnclassify(fcnn, fcnndatain.X, fcnndatain.R);
disp(classifieroutput.ClassificationRate)


% (c)
K = 100;
for I=0:K
    fcnndatain.X = X;
    fcnndatain.R = R;
    fcnndatain.Epochs = 100;

    % Train the network.
    [fcnn, fcnndataout] = fcnntrain(fcnn, fcnndatain);
    if fcnndataout.MSE > 0.05
        % occasionally, get 'trapped' in 0.5028
        break
    end
    disp(I)
end