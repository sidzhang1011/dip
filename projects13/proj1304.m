clc; clear; close all;
addpath ..;

% (a). based on Freeman chain codes for differentiating
imageFiles = ['letterA.tif'; 'letterB.tif'; 'letterC.tif'];
count = size(imageFiles, 1);

images = cell(count);
by = cell(count,1);
fcc = cell(3,1);
for i = 1:count
    images{i} = imread(imageFiles(i,:));
%     images{i} = imresize(images{i}, 0.2);
    bwb = bwboundaries(images{i});
    ad = cellfun('length', bwb);
    [maxdA, kA] = max(ad);
    by{i} = bwb{kA}; % Longest boundary.
    fcc{i} = freemanChainCode(by{i});
    disp(length(fcc{i}.fcc))
%     disp(fcc{i}.mm(1:30))
end

% B的mm 有最长的连续2， A.mm和C.mm比前面连续0要少
% 后面注释的数字是图像没有被resize的结果
c2A = maxRepeatedDigit(fcc{1}.fcc, 2);  % 2
c2B = maxRepeatedDigit(fcc{2}.fcc, 2);  % 32
c2C = maxRepeatedDigit(fcc{3}.fcc, 2);  % 13

c0A = repeatedZeroAtFirst(fcc{1}.mm);   % 3
c0C = repeatedZeroAtFirst(fcc{3}.mm);   % 14


% (b)
frd = cell(count,1);
for i=1:count
    frd{i} = frdescp(by{i});
end

ifrd = cell(count,1);
fcc1 = cell(count,1);
for i = 1:count
    nd = int16(0.18*length(frd{1}));
    if ~iseven(nd)
        nd = nd + 1;
    end
    ifrd{i} = round(ifrdescp(frd{i}, nd));
    fcc1{i} = freemanChainCode(ifrd{i});
end

% the commented data is based on 0.2*np
c2A1 = maxRepeatedDigit(fcc1{1}.fcc, 2);  % 3
c2B1 = maxRepeatedDigit(fcc1{2}.fcc, 2);  % 32
c2C1 = maxRepeatedDigit(fcc1{3}.fcc, 2);  % 12

c0A1 = repeatedZeroAtFirst(fcc1{1}.mm);   % 2
c0C1 = repeatedZeroAtFirst(fcc1{3}.mm);   % 16


% (c)
ia = imread('chromosome_boundary.tif');
[M, N] = size(ia);
se = strel('dis', 5, 0);       % Structuring element.
ia = imdilate(ia, se);
subplot(2,3,1), imshow(ia);

aboundary = bwboundaries(ia);
ad = cellfun('length', aboundary);
[maxdA, kA] = max(ad);
Abs = aboundary{kA}; % Longest boundary.
Af = bound2im(Abs, M, N);
subplot(2,3,2), imshow(Af);

frdc = frdescp(Abs);
ifrdc = ifrdescp(frdc, length(frdc));
ifullf = bound2im(ifrdc, M, N);
subplot(2,3,3), imshow(ifullf), title('full inversed fourier descriptor');

i8 = ifrdescp(frdc, 8);
i8f = bound2im(i8, M, N);
subplot(2,3,4), imshow(i8f), title('8-element if descriptors');

i4 = ifrdescp(frdc, 4);
i4f = bound2im(i4, M, N);
subplot(2,3,5), imshow(i4f), title('4-element if descriptors');

i2 = ifrdescp(frdc, 2);
i2f = bound2im(i2, M, N);
% subplot(2,3,6), imshow(i2f), title('2-element if descriptors');

maxi4y = max(i4(:, 2));
mini2y = min(i2(:, 2));
ni2 = i2 + [0, maxi4y - mini2y + 8];
ni2f = bound2im(ni2, M, 2*N);
ni4f = bound2im(i4, M, 2*N);
icombine = ni4f + ni2f;
subplot(2,3,6), imshow(icombine), 
title('4-element combined with 2-element');





% helper functions
function c = maxRepeatedDigit(digits, sd)
    c = 0;
    tempc = 0;
    maxlen = length(digits);
    for i=1:maxlen
        if digits(i) == sd
            tempc = tempc + 1;
        else
            if tempc > c
                c = tempc;
            end
            tempc = 0;
        end
    end
    % repeated char in the end
    if tempc > c
        c = tempc;
    end
end

function c = repeatedZeroAtFirst(digits)
    c = 0;
    maxlen = length(digits);
    for i=1:maxlen
        if digits(i) == 0
            c = c + 1;
        else
            break;
        end
    end
end