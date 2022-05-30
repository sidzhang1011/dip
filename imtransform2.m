function g = imtransform2(f, varargin)
%IMTRANSFORM2 2 - D image transformation with fixed output location
%   G = IMTRANSFORM2(F, TFORM, ...) applies a 2-D geometric transformation
%   to an image. IMTRANSFORM2 fixes the output image location to cover the
%   same region as the input image.
%   IMTRANSFORM2 takes the same set of optional parameter/value pairs as
%   IMTRANSFORM.

[M, N] = size(f);
xdata = [1 N];
ydata = [1 M];
g = imtransform(f, varargin{:}, 'XData', xdata, 'YData', ydata);

