function g = eigenvalueCorners(f, T)
%eigenvalueCorners Detects Corners in an image.
%   G = eigenvalueCorners(F, T) computes corner values at each point in
%   image F, where T is a threshold in the range [0,1], independently of
%   the clas of the input image. T defaults to 0.05.
%
%   This function is based on a method proposed in: J. Shi and C. Tomsi.
%   "Good Features to Track," Proceedings of the IEEE Conference on
%   Computer Vision and Pattern Recognition, Jun 1994, pp. 593-600.
%   The procedure is simply to implement Eq. (13-50) in DIPUM3E. See also
%   Gonzalez and Woods [2018].

%   Hints: Use MATLAB function gradient to compute the derivatives, paying 
%   attention to the fact that this function uses a (c, r) co­ordinate format. 
%   Also, because matrix C is symmetric and is only of size 2x2, you can use 
%   Eq. (13-50) to compute the eigenvalues.

if nargin == 1
    T = 0.05;
end

f = double(f);
[fs, ft] = gradient(f);

% w = [1 0 -1; 0 0 0; -1 0 1];
w = ones(3, 3)/9.0;

fssquare = fs .* fs;
fsft = fs .* ft;
ftsquare = ft .* ft;
a = filter2(w, fssquare);
b = filter2(w, fsft);
c = filter2(w, ftsquare);

phi2 = (a + c)/2.0 - ((4 * b.^2 + (a - c) .^ 2)/2.0) .^ 0.5;
phi2 = phi2/max(max(phi2(:)));

[u, v] = find(phi2 >= T);
g = [u,v];


