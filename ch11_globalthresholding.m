clc; clear; close all;
f = imread('noisy_fingerprint.tif');
count = 0;
T = mean2(f);
done = false;
while ~done
    count = count + 1;
    g = f > T;
    Tnext = 0.5*(mean(f(g)) + mean(f(~g)));
    done = abs(T - Tnext) < 0.5;
    T = Tnext;
end

g = imbinarize(f, T/255);
subplot(1,3,1), imshow(f);
subplot(1,3,2), imhist(f);
subplot(1,3,3), imshow(g);

% Otsu
[T2, SM]  = graythresh(f);
