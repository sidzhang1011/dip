clc; clear; close all;

I = false(10); I(1:2, 1:2) = 1;  I(5:7, 5:7) = 1;
fdvalues = regionprops(I, 'Area');

values = regionprops(double(I), 'Area');

% fdvalues 1x2, values: 1x1

