function imrect = imrectangle(f, specs)
%IMRECTANGLE Superimposes a rectangle on an image.
%   IMRECT = IMRECTANGLE(F, SPECS) displays a color rectangle
%   superimposed on the input grayscale image F and also outputs the result
%   as an RGB image, IMRECT, of class uint8, which is the original image
%   with the color rectangle superimposed on it.
%
%   SPECS is a structure with the following fields.
%
%   specs.Coordinates       A 1x2 vector containing the (c,r)
%                           coordinates of the top left corner of 
%                           the rectangle.
%   specs.Height            Height of the rectangle.
%   specs.Width             Width of the rectangle.
%   specs.LineWidth         Line width (in points) of the 
%                           border of the rectangle (defaults to 2).
%   specs.LineColor         Color of the border of the rectangle
%                           (defaults to red). Consult the documentation
%                           of MATLAB function rectangle for a list of
%                           valid colors.
%
%   Use the Toolbox function impixelinfo to get the coordinates of the
%   rectangle. This function outputs the cursor location in a (c,r) 
%   format.

if nargin ~= 2
    error('wrong input arguement number');
end

if ~isfield(specs, 'Coordinates') || ~isfield(specs, 'Height') || ...
    ~isfield(specs, 'Width')
    error('specs should have fields: Coordinates, Height & Width')
end

if ~isfield(specs, 'LineWidth')
    specs.LineWidth = 2;
end

if ~isfield(specs, 'LineColor')
    specs.LineColor = 'r';
end

t = specs.LineColor == ['r', 'g', 'b', 'c', 'm', 'y', 'k', 'w'];
if (max(t)  ~= 1)
    error('wrong linecolor')
end

t = specs.Coordinates;

rectangle('Position', [t(1), t(2), specs.Width, specs.Height], ...
    'EdgeColor', specs.LineColor, 'LineWidth', specs.LineWidth);

imrect = im2subim(f, specs);
