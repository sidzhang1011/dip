clc; close all; clear;

f = im2double(imread('flowers-red.jpeg'));  
subplot(2,2,1), imshow(f) % Fig. 11.28(a).

% Create a color superpixel image.
fSP = zeros(size(f),'like',f);
% Get the superpixel labels using 100 superpixels. 
N = 500;
[Lsp,NL] = superpixels(f,N);

idx = label2idx(Lsp); 
numRows = size(f,1); 
numCols = size(f,2);  

for j = 1:NL
% Because we are working with an RGB image, it is necessary 
% to extract the corresponding addresses for the three RCG 
% component images from idx.
    redldx = idx{j};
% idx is a linear index,so the next numRows*numCols indices 
% are for the green component.
    greenldx = idx{j} + numRows*numCols;
% And similarly for the blue component.
    blueldx = idx{j} + 2*numRows*numCols; 
    fSP(redldx) = mean(f(redldx));  
    fSP(greenldx) = mean(f(greenldx)); 
    fSP(blueldx) = mean(f(blueldx));
end

% Show overlay on superpixel image. 
mask = boundarymask(Lsp);
fSPO = imoverlay(fSP,mask,'w');
subplot(2,2,2), imshow(fSPO) % Fig. 11.28(b).
% Show the superpixel image.
subplot(2,2,3), imshow(fSP) % Fig. 11.28(c).
