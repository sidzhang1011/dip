function ulp = uppermostLeftmost(b)
%uppermostLeftmost Uppermost, leftmost point of a closed boundary.
%   ULP = uppermostLeftmost(B) finds the uppermost-leftmost point in an
%   np-by-2 matrix, B, of (x,y) = (row,col) coordinates defining a closed
%   digital boundary. The coordinates of the uppermost, leftmost point are
%   output in the 1-by-2 vector ULP = [xu, yu].

% Check the size of b for correctness.
if size(b,2) ~= 2
    error('Input b must be an np-by-2 matrix.')
end

% Boundary coordinates, where (x,y) = (r,c).
x = b(:, 1);
y = b(:, 2);

% Find the uppermost leftmost point in the sequence.
cx = find(x == min(x));
cy = find(y == min(y(cx)));
xu = x(cx(1));
yu = y(cy(1));

% Output.
ulp = [xu, yu];