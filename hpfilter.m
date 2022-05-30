function H = lpfilter(type, M, N, D0, n)
% HPFILTER Computes frequency domain highpass filters.
%   H = HPFILTER(TYPE, M, N, D0, n) creates the transfer function of a
%   highpass filter, H, of the specified TYPE and size (M-by-N). 
%   valid values for TYPE, D0, and n are:
%   
%   'ideal'     ideal lowpass filter with cutoff frequency D0. n need not
%   be supplied. D0 must be positive.
%
%   'btw'       Butterworth lowpass filter of order n, and cutoff frequency
%   D0. The default value for n is 1.0. D0 must be positive.
%
%   'gaussian'  Gaussian lowpass filter with cutoff (standard deviation)
%   D0. n need not be supplied. D0 must be positive.
%
%   H is of floating point class single. It is returned uncentered for
%   consistency with filtering function dftfilt. To view H as an image or
%   mesh plot, it should be centered using Hc = fftshift(H).

if nargin == 4
    n = 1; % default value of n.
end

% Generate highpass filter.
Hlp = lpfilter(type, M, N, D0, n);
H = 1 - Hlp;

