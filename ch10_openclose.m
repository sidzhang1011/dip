clc; close all; clear;

A = imread('shapes1.jpg');
A = rgb2gray(A);
% A = imcomplement(A);
dots = find(A >= 127);
A(:,:) = 0;
A(dots) = 255;

B = strel('square', 50);
O = imopen(A, B);
C = imclose(A, B);
L = imclose(O, B);
subplot(2,2, 1), imshow(A);
subplot(2,2,2), imshow(O);
subplot(2, 2, 3), imshow(C);
subplot(2, 2, 4), imshow(L);