function emap  = snakeMap(f, varargin)
%snakeMap Computes an edge map for use in the snake iterative algorithm.
%   EMAP = snakeMap(F, T, SIG, NSIG, ORDER) computes the edge map, EMAP, of
%   input image F. If only F is provided in the input, EMAP will equal the
%   magnitude of the gradient of F (see Chapter 3) without thresholding. If
%   T is also provided, EMAP is thresholded so that, at any point, EMAP = 1
%   if EMAP > T; it is zero otherwise. If T is the string 'auto',
%   thresholding is done automatically by function edge. Otherwise, T is
%   expected to be a number in the range [0,1]. No smoothing filter is
%   applied. If all inputs are povided, the magnitude of the gradient is
%   thresholded and filtered using a Gaussian kernel of size
%   NSIG*SIG-by-NSIG*SIG where SIG is the standard deviation and NSIG is an
%   integer giving the number of standard deviations we want the kernel
%   size to be. The function adjusts the kernel size to be the odd size
%   closest to the specified size. ORDER is a character string with the
%   following possible values: If order = 'before' then image F is filtered
%   before the map (magnitude of the gradient) is computed. If order =
%   'after' filtering is performed on the edge map after it is computed. If
%   ORDER = 'both' filtering is performed on the image first, and then
%   after the edge map is computed. If ORDER = 'none', no filtering is
%   performed. This is the default. Gradients are computed using the Sobel
%   kernels.

% Preliminaries.
% Scale the image to the floating point intensity range [0, 1].
f = im2double(f);
% Set defaults.
thresholding = true;
filtering = true;
if nargin == 1
    % Only one input. No thresholding.
    thresholding = false;
    % No filtering will be done.
    filtering = false;
elseif numel(varargin) == 1
    % Only two inputs.
    T = varargin{1};
    filtering = false;
elseif numel(varargin) == 4
    T = varargin{1};
    sig = varargin{2};
    nsig = varargin{3};
    order = varargin{4};
else
    % Filtering is expected, but not enough inputs were provided.
    error('Not enough inputs to define the filtering operation.')
end

% Filter the input image.
% If filtering is called for, form the Gaussian lowpass kernel.
if filtering
    % Form Gaussian kernel using function fspecial.
    kernelSize = floor(nsig * sig);
    % Find the closest odd number of kernelSize.
    if iseven(kernelSize)
        kernelSize = kernelSize + 1;
    end
    % Gaussian kernel.
    w = fspecial('gaussian', kernelSize, sig);
end
% Check to see if filtering is to be done here.
if filtering
    if isequal(order, 'before') || isequal(order, 'both')
        f = im2double(imfilter(f, w, 'conv', 'symmetric'));
    end
end

% COMPUTE the edge map. We use function edge to compute the gradient image.
% Because thresholding is done as part of the function, we have to
% determine at this point if thresholding is to be done and, if so, whether
% 'auto' was specified or not. Either way, the resulting map is thinned
% automatically by function edge.
if thresholding
    if isequal(T, 'auto')
        emap = double(edge(f, 'sobel'));
    else
        emap = double(edge(f, 'sobel', T));
    end
else
    % No thresholding; use edge with a 0 threshold.
    emap = double(edge(f, 'sobel', 0));
end
if min(emap(:)) == max(emap(:))
    error('Threshold is too low/high. All values of emap are equal')
end

% Filter edge map.
% Check to see if filtering was specifed.
if filtering
    % If order is 'after', or 'both' then filter the edge map now.
    if isequal(order, 'after') || isequal(order, 'both')
        emap = imfilter(im2double(intensityScaling(emap)), ...
            w, 'conv', 'symmetric');
    end
end

% Scale the edge map to the full range [0, 1].
emap = intensityScaling(emap);


