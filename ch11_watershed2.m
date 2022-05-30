clear; clc; close all;

Cl = imcircle(500,500,330,170,130,131);
C2 = imcircle(500,500,170,330,130,131); 
I = Cl | C2;
subplot(4,4,1), imshow(I) % Fig. 11.39(a).

    
negD =  I;

for i = 1:7
    D = bwdist(~I);

    negD =  -D;

    L=  watershed(negD);
%     ridges = zeros(size(I));
%     ridges(L == 0) = 1;

    negD(~I) = min(negD(:));

    maxv = max(negD(:));
    minv = min(negD(:));
    
    bench = minv + 0.95*(maxv - minv);
    
    I(negD >= bench) = 1;
    I(negD < bench) = 0;    
    
    subplot(4,4,2*i), imshow(I, []);    
    sD = negD;
    sD(L == 0) = max(negD(:));
    subplot(4,4,2*i+1), imshow(sD, []);    
end
