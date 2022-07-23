function output = percepclassifier(input)
%PERCEPTCLASSIFIER used a trained perceptron to classify the patterns
%   OUTPUT = perceptronClassify(INPUT) perceptron classifier for two
%   pattern classes as defined in Eq. (14-25). The input and output
%   parameters are structures defined as follows.
%
%   Parameter input is a structure with the following fields:
%    
%   input.X             A matrix of size n-by-np whose columns are
%                       n-dimensional input pattern vectors, and np is
%                       the number of such vectors. For example, for a
%                       set of 100, 3-element patterns, matrix inputs.X
%                       would be of size 3-by-100. The function augments
%                       the patterns by appending a 1 at the end of all
%                       pattern vectors.
% 
%   input.W             An augmented weight vector of size (n + 1)-by-1
%                       whose coefficients define the perceptron.
%
%   input.r             An optional 1-by-np class membership vector that
%                       contains the class of each input pattern (column
%                       of input.X). If the ith pattern vector belongs
%                       to class 1, then the ith element of input.r
%                       should be 1. Otherwise it should be -1. If this
%                       vector is provided, the function computes the
%                       correct classification rate.
%
%   Parameter output is a structure with the following fields:
%
%   output.r            A 1-by-np vector whose kth element contains the
%                       class label assigned by the classifier to the 
%                       kth input pattern vector (kth column of
%                       input.X). If the ith element of output.r is 1,
%                       the ith pattern vector was classified into class
%                       1. If the ith element is -1, the vector was
%                       classified into class 2. If the ith element is
%                       0, no decision could be made.
%
%   output.NumErrors    The number of errors committed by the
%                       classifier. This output is empty if input.r is
%                       not provided.
%
%   output.Rate         The percent of patterns classified correctly.
%                       This output is empty if input.r is not provided.

% PRELIMINARIES.
% Number of patterns.
np = size(input.X,2);
% Make sure the weight vector is a column vector.
input.W = input.W(:);
% Augment the pattern vectors.
X = cat(1,input.X,ones(1,np));
% Initialize the outputs that depend on whether input.r. was provided.
output.NumErrors = [];
output.Rate = [];

% CLASSIFY THE PATTERNS.
% Preallocate memory for loop speed.
output.r = ones(1, np);
for I = 1:np
    r = input.W' * X(:, I);
    if r > 0
        output.r(I) = 1;
    elseif r < 0
        output.r(I) = -1;
    end
end

if isfield(input, 'r')
    % Make sure it is a row vector.
    input.r = input.r(:)';
    output.NumErrors = sum(input.r ~= output.r);
    output.Rate = (np - output.NumErrors) / np *100;
end
