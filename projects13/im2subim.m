function subim = im2subim(f, specs)
%IM2SUBIM Extracts a subimage from a grayscale image.
%   SUBIM = IM2SUBIM(F, specs) extracts a subimage, SUBIM, from image F.
%   SUBIM is of the same class as F.
%
%   SPECS is a structure with the following fields.
%
%   specs.Coordinates       A 1x2 vector containing the (c,r) coordinates
%                           of the top left corner of the subimage.
%   specs.Height            Height of the subimage in pixels.
%   specs.Width             Width of the subimage in pixels.
%
%   Use the custom function imrectangle to define interactivesly the
%   coordinates and size of the rectangle for a given application.

if nargin ~= 2
    error('wrong input arguement number');
end

[M, N] = size(f);
if M <= 1 || N <= 1
    error('f should be a gray image')
end

if ~isfield(specs, 'Coordinates') || ~isfield(specs, 'Height') || ...
    ~isfield(specs, 'Width')
    error('specs should have fields: Coordinates, Height & Width')
end

t = specs.Coordinates;
subim = f(t(1)+1:t(1)+specs.Height, t(2)+1:t(2)+specs.Width);
