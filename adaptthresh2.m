function g = adaptthresh2(f, nhood, a, b, meantype)
%ADAPTTHRESH2 Local adaptive thresholding.
%       G = ADAPTTHRESH2(f,NHOOD,a,b,MEANTYPE) thresholds image F by
%   computing a local threshold at the center,(x,y), of every
%   neighborhood in f. The size of the neighborhood is defined by NHOOD, 
%   a matrix of zeros and ones in which the nonzero elements specify the 
%   neighbors used in the computation of the local mean and standard
%   deviation. The size of NHOOD must be odd in both dimensions.
%
%   The segmented image is given by
%
%               1 if(f>a*SIG)AND(f>b*MEAN) 
%       G =
%               0 otherwise
%
%   where SIG is a matrix of the same size as f containing the local
%   standard deviations. If MEANTYPE = 'local' (the default), then MEAN 
%   is a matrix of local means. If MEANTYPE = 'global', then MEAN is the 
%   global mean of f, a scalar. Constants a and b are nonnegative
%   scalars. SIG and MEAN are computed in this function.

narginchk(4, 5);

if nargin == 4
    meantype = 'local';
end

if (ndims(f) ~= 2)
     error('f should be 2-d image');
end

if (ndims(nhood) ~= 2)
    error('nhood should be 2-d data with 0 or 1');
end

[hr, hc] = size(nhood);

if iseven(hr) || iseven(hc)
    error('nhood should be odd-by-odd matrix');
end

for i=1:hr
    for j=1:hc
        if nhood(i, j) ~= 0 && nhood(i, j) ~= 1
            error('nhood should be composed of 0 and 1');
        end
    end
end

if (a <= 0 || b <= 0)
    error('a and b should > 0');
end

f = double(f);
[fr, fc] = size(f);
mxyall = zeros(fr, fc);
taoall = zeros(fr, fc);

useLocal = true;
switch meantype
    case 'all'
        mg = mean(mxyall(:));
        mxyall(:,:) = mg;
        uesLocal = false;
    case 'local'
        useLocal = true;
end


extf = zeros(fr + hr - 1, fc + hc - 1);
halfhr = (hr-1)/2;
halfhc = (hc-1)/2;
extf(halfhr+1: halfhr + fr, halfhc+1 : halfhc + fc) = f;

positiveIndex = find(nhood > 0);
for row = 1:fr
    for col = 1:fc
        localmatrix = extf(row:row+hr-1, col:col+hc-1);
        localcol = localmatrix(:);
        localcol = localcol(positiveIndex);
        taoall(row, col) = sqrt(var(localcol));
        if useLocal
            mxyall(row, col) = mean(localcol);
        end
    end
end

g1 = (f > a * taoall);
g2 = (f > b * mxyall);
g = g1 .* g2;
% g = taoall/max(taoall(:));

