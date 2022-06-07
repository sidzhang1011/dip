clc; clear; close all;

f1 = imread('random_matches.tif');
subplot(2,4,1), imshow(f1);
f2 = imread('ordered_matches.tif');
subplot(2,4,2), imshow(f2);

[srad1, sang1, S1] = specxture(f1);
[srad2, sang2, S2] = specxture(f2);

subplot(2,4,3), imshow(S1, []), title('random spectrum');
subplot(2,4,4), imshow(S2, []), title('ordered spectrum');

subplot(2,4,5), plot(srad1, 'r'), xlabel('r'), ylabel('S(r)'), 
    title('random spectrum per radius');
subplot(2,4,6), plot(sang1, 'r'), xlabel('theta'), ylabel('S(theta)'), 
    title('random spectrum per theta');
subplot(2,4,7), plot(srad2, 'r'), xlabel('r'), ylabel('S(r)'), 
    title('random spectrum per radius');
subplot(2,4,8), plot(sang2, 'r'), xlabel('theta'), ylabel('S(theta)'), 
    title('random spectrum per theta');
