function lmean = localmean(f, nhood)
%LOCALMEAN Computes the local mean at every point in an image.
%   LMEAN = LOCALMEAN(F, NHOOD) computes the mean at the center of every 
%   neighborhood of F defined by NHOOD, a matrix of zeros and ones where
%   the nonzero elements specify the neighbors used in the computation of
%   the local means. The size of NHOOD must be odd in each dimension; the
%   default is ones(3). Output LMEAN is a matrix of the same size as F
%   containing the local mean at each point. To avoid introducing an
%   intensity bias, a neighborhood computation is normalized by dividing it
%   by the sum of its elements.

narginchk(1,2);
if nargin == 1
    nhood = ones(3);
end

f = double(f);

if (ndims(f) ~= 2) 
    error('f should be a 2-d image');
end

if (ndims(nhood) ~= 2)
    error('nhood should be a matrix');
end

nhood = double(nhood);
nhood = nhood/sum(sum(nhood));
lmean = conv2(f, nhood);
[m,n] = size(f);
l = (size(nhood, 1) - 1)/2;
lmean = lmean(1+l:m+l, 1+l:n+l);
lmean = uint8(lmean);


