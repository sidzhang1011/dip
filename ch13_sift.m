clc; clear; close all;

f1 = im2double(imread('integrated-ckt-damage.tif'));
f1 = rgb2gray(f1);
f2 = imrotate(f1, 25, 'crop');

subplot(2,2,1), imshow(f1);
subplot(2,2,2), imshow(f2);

points1 = detectFASTFeatures(f1);
points2 = detectFASTFeatures(f2);

[descp1, valpoints1] = extractFeatures(f1, points1);
[descp2, valpoints2] = extractFeatures(f2, points2);

disp(descp1)

indexPairs = matchFeatures(descp1, descp2, 'Unique',true, ...
    'MatchThreshold', 0.1, 'MaxRatio', 0.75);
matchPoints1 = valpoints1(indexPairs(:,1), :);
matchPoints2 = valpoints2(indexPairs(:,1), :);

disp(matchPoints1)

subplot(2,2,3), showMatchedFeatures(f1, f2, matchPoints1, matchPoints2);
