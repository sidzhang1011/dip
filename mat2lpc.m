function y = mat2lpc(x, pf)
%MAT2LPC Compresses a matrix using 1-D lossles predictive coding.
% Y = MAT2LPC(X,PF) encodes matrix X using 1-D lossless predictive
% coding. A linear prediction of X is made based on the coefficients
% in PF. If PF is omitted, PF = 1 (for previous pixel coding) is
% assumed. The prediction error is then computed and output as encoded % matrix Y.
%
% See also LPC2MAT.

narginchk(1,2); 
if nargin < 2
    pf = 1;
end

x = double(x);
[m,n] = size(x);
p = zeros(m,n);
xs = x;     zc = zeros(m,1);

for j = 1:length(pf)
    xs = [zc xs(:, 1:end - 1)]; 
    p = p + pf(j)*xs;
end

y = x - round(p);