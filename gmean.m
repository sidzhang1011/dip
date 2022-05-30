function v = gmean(A)
%GMEAN Geometric mean of columns.
%   V = GMEAN(A) computes the geometric mean of the columns of A. v
%   is a row vector with size(A,2) elements.
%
%   Sample M-file used in Chapter 3.

m = size(A, 1);
v = prod(A,1) .^ (1/m);
