clc; clear all; close all;
iptsetpref imshowAxesVisible on

% f = imread('circuit-board.png');
% f = imresize(f, 0.5);
f = imread('lunar-shadows.jpg');

%% axis auto %%
% theta = 1*pi/4;
% T = [   cos(theta)    sin(theta)    0;  ...
%         -sin(theta)   cos(theta)    0;   ...
%         0               0           1];
% tform = maketform('affine', T);
% [g, xdata, ydata] = imtransform(f, tform, 'FillValue', 128);
% imshow(f)
% hold on
% imshow(g, 'XData', xdata, 'YData', ydata)
% axis auto
% axis on


%% imtransform2
tform1 = maketform('affine', [1 0 0; 0 1 0; 100 200 1]);
g1 = imtransform2(f, tform1, 'FillValue', 200);
h1 = imtransform(f, tform1, 'FillValue', 200);
imshow(g1), figure, imshow(h1);

tform2 = maketform('affine', [0.25 0 0; 0 0.25 0; 0 0 1]);
g2 = imtransform2(f, tform2, 'FillValue', 200);
h2 = imtransform(f, tform2, 'FillValue', 200);
figure, imshow(g2), figure, imshow(h2)