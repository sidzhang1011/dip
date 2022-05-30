function [ratio, maxdiff] = ifwtcompare(f, n, wname)
%IFWTCOMPARE Compare waverec2 and waveback.
%   [RATIO, MAXDIFF] = IFWTCOMPARE(F, N, WNAME) compares the operation of
%   Wavelet Toolbox function WAVEREC2 and custom function WAVEBACK.
%
%   INPUTS:
%     F             Image to transform and inverse transform.
%     N             Number of scales to compute.
%     WNAME         Wavelet to use.
%
%   OUTPUTS:
%     RATIO         Execution time ratio (custom/toolbox).
%     MAXDIFF       Maximum generated image difference.

% Compute the transform and get output and computation time for waverec2.
[c1, s1] = wavedec2(f, n, wname);
w1 = @() waverec2(c1, s1, wname);
reftime = timeit(w1);

% Compute the transform and get output and computetion time for waveback.
[c2, s2] = wavefast(f, n, wname);
w2 = @() waveback(c2, s2, wname);
t2 = timeit(w2);

% Compare the results.
ratio = t2 / reftime;
diff = double(w1()) - w2();
maxdiff = abs(max(diff(:)));
