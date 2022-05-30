function A = compassAngle(f, T)
%compassAngle angles of gradient image.
%   A = compassAngle(f, T) computes the angle at each point of the 
%   gradient image of inut image f, using compass kernels. Each value of A
%   is an angle in the range [0, 315] in increments of 45 degrees. T is a
%   threshold in the range [0,1] representing a percentage of the maximum
%   angle in A. If T is not included in the input, no thresholding is
%   performed and A will be a matrix of class double containing the angle
%   value at each point in the input image. 