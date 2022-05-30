clear; clc; close all

f = imread('totem-poles.png', 'png');
f = rgb2gray(f);
subplot(2,2,1), imshow(f);

% Compute 3000 superpixels.
[L,NL] = superpixels(f,3000);

% L is a matrix of labels and thus contains no visual information of interest. 
% To display it, we first replace each superpixel by its average value.
fSP = zeros(size(f));

% Convert labels to indices.
idx = label2idx(L);         % idx is a cell array. 

% Process each superpixel region.
for labelVal = 1:NL
    grayldx = idx{labelVal};
    fSP(grayldx) = mean(f(grayldx)); 
end

% Scale fSP to the full intensity range.
fSP = mat2gray(fSP); % Could also use custom function intensityscaling.

% Superimpose the superpixel boundaries on the image. 
mask = boundarymask(L);
fSPO = imoverlay(fSP,mask,'w');

% Show the results.
subplot(2,2,2), imshow(fSPO);    %   Fig. 11.25(b).  
subplot(2,2,3), imshow(fSP);     %   Fig. 11.25(c).
subplot(2,2,4), imshow(mask);
