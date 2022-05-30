function w = compassKernels(dir)
%compassKernels generates the Kirsch compass kernels.
%   w = compassKernels(dir) generates a 3-by-3 compass kernel of specified
%   direction (dir).
%
%   To generate a kernel in a specified direction use one of the following
%   options:
%
%       dir     'n'/'nw'/'w'/'sw'/'s'/'se'/'e'/'ne'/'all'
%
%   In the first eight options, w will be of size 3-by-3. In the last
%   option, w contains all eight kernels, so it will be of size
%   3-by-3-by-8.
if nargin < 1
    dir = 'all';
end

switch dir
    case 'n'
        w = [-3 -3 5; -3 0 5; -3 -3 5];
    case 'nw'
        w = [-3 5 5; -3 0 5; -3 -3 -3];
    case 'w'     
        w = [5 5 5; -3 0 -3; -3 -3 -3];
    case 'sw'     
        w = [5 5 -3; 5 0 -3; -3 -3 -3];
    case 's'     
        w = [5 -3 -3; 5 0 -3; 5 -3 -3];
    case 'se'     
        w = [-3 -3 -3; 5 0 -3; 5 5 -3];
    case 'e'     
        w = [-3 -3 -3; -3 0 -3; 5 5 5];
    case 'ne'     
        w = [-3 -3 -3; -3 0 5; -3 5 5];
        
    case 'all'
        w = zeros(3,3,8);
        w(:,:,1) = [-3 -3 5; -3 0 5; -3 -3 5];
        w(:,:,2) = [-3 5 5; -3 0 5; -3 -3 -3];
        w(:,:,3) = [5 5 5; -3 0 -3; -3 -3 -3];
        w(:,:,4) = [5 5 -3; 5 0 -3; -3 -3 -3];
        w(:,:,5) = [5 -3 -3; 5 0 -3; 5 -3 -3];
        w(:,:,6) = [-3 -3 -3; 5 0 -3; 5 5 -3];
        w(:,:,7) = [-3 -3 -3; -3 0 -3; 5 5 5];
        w(:,:,8) = [-3 -3 -3; -3 0 5; -3 5 5];

    otherwise
        error('Unknown direction')
end
end
