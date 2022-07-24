function output = lmsePerceptronTrain(input)
%lmsePerceptronTrain LMSE training of two-class perception.
%   OUTPUT = lmsePerceptronTrain(INPUT) training of two-class perceptron. 
%   The input and output parameters of structures are defined as follows.
%
%   Parameter input is a structure with the following fields:
%
%   input.X         A matrix of size n-by-np whose columns are
%                   n-dimensional input pattern vectors, and np is the
%                   number of such vectors. For example, for a set of 100,
%                   3-element patterns, matrix inputs.X would be of size
%                   3-by-100. The function augments the patterns by
%                   appending a 1 at the end of all pattern vectors.
%
%   input.r         Class memebership vector of size 1-by-np whose kth
%                   value is 1 if the pattern vector in the kth column of X
%                   belongs to class c1; otherwise the kth value of input.r
%                   is -1.
%
%   input.Alpha     Learning rate positive scalar that defaults to 0.5.
%
%   input.W0        Initial augmented weight vector of size (n + 1)-by-1.
%                   Its components default to uniform random numbers in the
%                   range [0,1].
%
%   input.NumEpochs The number of training epochs. Defaults to 100.
%   
%   input.MSEDelta  The algorithm stops when the MSE is less than or equal
%                   to this threshold.
%
%   Parameter output is a structure with the following fields.
%
%   output.W        (n + 1)-by-1 weight vector at completion of training.
%                   This may or not be a solution that separates the two
%                   classes, depending the number of epochs specified and
%                   whether the classes are linearly separable.
%
%   output.MSE      the value of the MSE when the algorithm stops.
%
%   output.ActualEpochs The actual number of epochs of training executed.

% AUGMENT the pattern vectors.
% Number of patterns.
np = size(input.X, 2);
% Augment the pattern vectors.
X = cat(1, input.X, ones(1, np));

% SET DEFAULTS.
if ~isfield(input, 'Alpha')
    input.Alpha = 0.5;
end
if ~isfield(input, 'NumEpochs')
    input.NumEpochs = 100;
end
if ~isfield(input, 'W0')
    rng('shuffle');
    input.W0 = rand(size(X,1),1); 
end
if ~isfield(input, 'MSEDelta')
    input.MSEDelta = 0.001;
end


% INITIALIZATION.
% Make sure that input.w0 is a column vector. 
input.W0 = input.W0(:);
% Initial values for loop.
w_last = input.W0;
w = input.W0;
output.ActualEpochs = 0;

% ITERATE.
E = zeros(1, np);
for I = 1:input.NumEpochs
    over = true;
    for J = 1:np
        t = w_last'*X(:,J);
        E(J) = 0.5 * (input.r(J) - t) ^ 2;
        if E(J) > input.MSEDelta
            w = w_last + input.Alpha * (input.r(J) - t) * X(:,J);
            w_last = w;            
            over = false;
        end
    end
       
    output.MSE(I) = sum(E(:))/np;

    % Exit if E(i) <= input.MSEDelta for i = 1, 2, ..., np
    if over
        break
    end
end
output.ActualEpochs = I;
output.W = w_last;