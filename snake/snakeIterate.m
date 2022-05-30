function [xs, ys] = snakeIterate(alpha, beta, gamma, x, y, NI, Fx, Fy)
%snakeIterate Iterative solution of the snake equation.
%   [XS, YS] = SNAKEITERATE(ALPHA，BETA, GAMMA, X, Y,  NI, Fx, Fy) computes
%   the [XS, YS] coordinates of a segmentation snake using the iterative
%   solution in Eq.(12-7) of DIPUM3E. Vectors X and Y are the initial
%   coordinates of the snake (provided in sequential order). These vectors
%   are updated during iteration. ALPHA, BETA, and GAMMA are parameters in
%   Eq. (12-7) and (12-8), and Fx, Fy are the 2D force arrays obtained, for
%   example, using DIPUM3E function snakeForce.
%
%   This function is normally run within an outer loop with snake-point
%   respacing after each execution of the loop. NI controls the number of
%   iterations of Eq. (12-7) before the snake points are respaced. A common
%   value of NI is 1, indicating one execution of point respacing after
%   each iteration of Eq. (12-7). 

% Preliminaries.
K = numel(x);
% Multiply the force by gamma.
Fx = gamma * Fx;
Fy = gamma * Fy;

% Construct matrix A in Eq. (12-8) for use in Eq. (12-7).
% First construct matrix D2 in Eq. (12-9).
a = -2 * ones(K, 1);
b = 1 * ones(K-1, 1);
D2 = diag(a) + diag(b, -1) + diag(b, 1);
D2(1, K) = 1;
D2(K, 1) = 1;

% Next construct D4 in Eq. (12-10).
a = 6 * ones(K, 1);
b = -4 * ones(K-1, 1);
c = 1 * ones(K-2, 1);
D4 = diag(a) + diag(b, -1) + diag(b, 1) + diag(c, -2) + diag(c, 2);
D4(1, K) = -4;
D4(K, 1) = -4;
D4(1, K-1) = 1;
D4(K-1, 1) = 1;
D4(2, K) = 1;
D4(K, 2) = 1;
% Construct matrix A. The inverse operation is performed during operation.
D = alpha * D2 - beta * D4;
A = eye(K) - D;

% Iteration solution.
for I = 1:NI
    % Obtain the force vectors fx and fy in Eq. (12-7). These are obtained
    % from Fx and Fy, the 2-D array components of the force field F, by
    % interpolating values of Fx and Fy at the locations of the current
    % snake coordinates, x and y. The 0 in the following function call
    % avoids NaNs in areas where there are no points to interpolate. The
    % order y,x is because function interp2 works with (col,row), as
    % opposed to (row,col) as in the book.
    fx = interp2(Fx, y, x, 'linear', 0);
    fy = interp2(Fy, y, x, 'linear', 0);

    % Compute new values of x and y using Eq.(12-7). Note the use of x =
    % A\(x + fx), as opposed to x = inv(A) * (x + fx), and similarly for y.
    % The former method is faster and more accurate.

    x = A\(x + fx);
    y = A\(y + fy);

end

% Form the snake.
xs = x;
ys = y;








