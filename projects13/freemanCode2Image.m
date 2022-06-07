function [I,b,b0] = freemanCode2Image(fcc, mag)
%freemanCode2Image Embeds a Freeman chain code boundary in an image.
%   [I, B, B0] = freemanCode2Image(FCC, MAG) scales the Freeman chain code
%   FCC by multiplying its coordinates by the positive scalar magnification
%   factor MAG (the default value is 2). In the output, B0 is an np-by-2
%   matrix whose rows contain the [row, col] coordinates of FCC. B is a
%   matrix of the same size as B0 containing the coordinates of the scaled
%   boundary. I is a binary image in which the foreground points are the
%   coordinates of B. I is square, of dimensions equal to twice the maximum
%   of the width or height of the scaled boundary. It is assumed that the
%   Freeman chain code forms a closed boundary.
%
%   To simplify the code, this function works only with 8-directional chain
%   code boundaries. Input FCC is examined to determin if it is a
%   4-directional code. If it is, its directions, 0,1,2,3, are converted to
%   8-directional code directions 0,2,4,6.
%
%   NOTE: If MAG is too large with respect to max(height,width) of the
%   chain boundary, the boundary in I may be too thin with respect to the
%   size of I and, consequently, for the resolution of some displays. In
%   such cases, the boundary may show partially or not at all.

addpath ..;

if nargin == 1
    mag = 2;
end

[row, col]  = code2coordinates(fcc);
b0 = [row, col];
b = b0 * mag;
bottom = max(b(:, 2));
right = max(b(:, 1));
width = 2 * max(bottom, right);
I = zeros(width);
lines = fcc.x0y0 * mag;
for i = 1:length(b)-1
    [x, y] = intline(b(i,1), b(i+1,1), b(i,2), b(i+1,2));
%     cat(1, lines, [x,y]);
    lines = [lines; [x,y]];
end
I(sub2ind(size(I), lines(:,1), lines(:,2))) = 1;
