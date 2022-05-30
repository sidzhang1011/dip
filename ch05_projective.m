clc; clear all; close all;
iptsetpref imshowAxesVisible on

f = imread('house.jpg');
clc; clear all; close all;
iptsetpref imshowAxesVisible on

T = [-2.7390 0.2929 -0.6373; ...
      0.7426 -0.7500 0.8088; ...
      2.8750 0.7500  1.0000];

tform = maketform('projective', T); % x = x'/h, y = y'/h

vistform(tform, pointgrid([0 0; 1 1]))

f = checkerboard(50);
T3 = [0.4788 0.0135 -0.0009; ...
      0.0135 0.4788 -0.0009; ...
      0.5059 0.5059 1.0000];
tform3 = maketform('projective', T3);
g3 = imtransform(f, tform3);
figure, imshow(g3, []);
