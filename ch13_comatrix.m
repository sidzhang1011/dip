clc; clear; close all;

f = [1 1 7 5 3 2; 
     5 1 6 1 2 5;
     8 8 6 8 1 2; 
     4 3 4 5 5 1;
     8 7 8 7 6 2; 
     7 8 6 2 6 2];

f = mat2gray(f);
offsets = [0 1];
[GS, FS] = graycomatrix(f, 'NumLevels', 8, 'Offset', offsets);

f2 = imread('texture_sinusoidal.tif');
G2 = graycomatrix(f2, 'NumLevels', 256);
G2n = G2/sum(G2(:));    %Normalizedmatrix.
fdvalues2 = graycoprops(G2, 'all'); % texture feature values.
maxProbability2 = max(G2n(:));
contrast2 = fdvalues2.Contrast;
Corr2 = fdvalues2.Correlation;
energy2 = fdvalues2.Energy;
hom2 = fdvalues2.Homogeneity;
for k = 1:size(G2n, 1)
    sumcols(k) = sum(-G2n(k, 1:end) .* log2(G2n(k, 1:end) + eps));
end
entropy2 = sum(sumcols);

% Look at a distance of 50 pixels to the right.
offsets = [zeros(50,1) (1:50)']; 
G2 = graycomatrix(f2, 'Offset', offsets);
% G2 is of size 8-by-8-by-50.
fdvalues2 = graycoprops(G2, 'Correlation');
% Plot the results.
subplot(1,2,1), plot([fdvalues2.Correlation]);
xlabel('Horizontal Offset')
ylabel('Correlation')
