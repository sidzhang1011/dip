function h = ntrop(x, n)
%NTROP Computes a first-order estimate of the entropy of a matrix.
%   H = NTROP(XjN) returns the entropy of matrix X with N symbols. N = 
%   256 if omitted but it must be larger than the number of unique
%   values in X for accurate results. The estimate assumes a
%   statistically independent source characterized by the relative
%   frequency of occurrence of the elements in X. The estimate is a
%   lower bound on the average number of bits per unique value (or
%   symbol) when coding without coding redundancy.

narginchk(1,2);             % Check input arguments
if nargin < 2
    n = 256;
end

x = double(x);
xh = histcounts(x(:), n);
xh = xh / sum(xh(:));

% Make mask to eliminate 0's since log2(0) = -inf.
i = find(xh);

h  = -sum(xh(i) .* log2(xh(i)));        % Compute the entropy
end
