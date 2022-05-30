clear; clc; close all;

Cl = imcircle(500,500,330,170,130,131);
C2 = imcircle(500,500,170,330,130,131); 
I = Cl | C2;
subplot(2,4,1), imshow(I) % Fig. 11.39(a).

D0 = bwdist(I);
subplot(2,4,2), imshow(D0, []), title('D0');

D = bwdist(~I);
subplot(2,4,3), imshow(D, []), title('D');

negD =  -D;
% D1 = bwdist(negD);
subplot(2,4,4), imshow(negD, []), title('negD'); 

L=  watershed(negD);
ridges = zeros(size(I));
ridges(L == 0) = 1;
subplot(2,4,5), imshow(ridges), title('ridges');

Iseg = I;
Iseg(L == 0) = 0;
subplot(2,4,6), imshow(Iseg), title('seg');

negD(~I) = min(negD(:));
subplot(2,4,7), imshow(negD, []), title('negD - keep bg');