function [d, minval] = minDistanceClassifier(X, M)
%MINDISTANCECLASSIFIER Implements a minimum distance classifier.
%   [D,MINVAL] = MINDISTANCECLASSIFIER(X, M) classifies a set of NP,
%   n-dimensional pattern vectors (rows of NP-by-n matrix X) into one of 
%   NC of classes. Classification is done by computing and selecting the
%   minimum distance between each row of X all the rows of NC-by-n 
%   matrix M, which are the mean (prototype) vectors of the NC classes. 
%   Output D is an NP-by-1 vector with the property that the numerical
%   value of each element gives the class number of the pattern vector
%   corresponding to that location in the vector. For example, if D(k) = 4,
%   the pattern vector in the kth row of X belongs to class 4. Output
%   MINVAL is a vector, the same size as D, in which each element is the
%   minimum value computed by the classifier for the corresponding element
%   in D.

% This function is a straightforward implementation of Eq. (14-4) in
% DIPUM3E, without the sqrt because leaving that out does not affect the
% order of smallest to largest values needed to make a classification.
p = size(X, 1);
n = size(X, 2);
q = size(M, 1);
distances = sum(abs(reshape(X, p, 1, n) - reshape(M, 1, q, n)).^2, 3);

% The index location of the minimum value along each row of distances
% gives the class of the pattern vector corresponding to that row.
[minval, indices] = min(distances, [], 2);
d = indices;