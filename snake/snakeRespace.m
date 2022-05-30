function [xp, yp] = snakeRespace(x, y)
%snakeRespace respaces the coordinates of a snake uniformly.
%   [XP, YP] = snakeRespace(X, Y) respaces snake coordinates [X, Y] by
%   redistributing the points so that they are spaced uniformly in terms of
%   arc length. The number of points in the output [XP,YP] is the same as
%   in the input [X,Y]. It is assumed that the input snake is a closed
%   planar curve. The output also is closed. Respacing is also referred to
%   as reparemeterization.

% Preliminaries
% Number of input points.
np = numel(x);

% Interpolate the input coordinates and respace them uniformly.
% The following 3rd party utility function performs interpolation of the
% input. The number of points out is equal to the number of points in, but
% the points in the output are spaced so that they have the same arc length
% spacing. We use linear interpolation for speed, but the function is also
% capable of using splines, which in general are more accurate. Linear
% interpolation is much faster and for snake work is usually sufficient.
pt = interparc(np, y, x, 'linear');

% Obtain the output reparameterized coordinates.
% Interparc uses a (col, row) format, as opposed to our book coordinate
% convention (row, col). We take this into consideration in the following
% two statements.
% Row coordinates.
xp = pt(:, 2);
% Column coordinates.
yp = pt(:, 1);

% Make sure the curve is closed.
xp(end) = xp(1);
yp(end) = yp(1);
