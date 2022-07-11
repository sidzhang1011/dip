clc; clear; close all;
addpath('..');

foriginal = imread('bubbles.tif');
[m, n] = size(foriginal);
subplot(2,3,1), imshow(foriginal), title('original');

f1 = imbinarize(foriginal, 195/255.0);
subplot(2,3,2), imshow(f1), title('global thresholding');

% f2 = imgaussfilt(double(f1), 3);
% f2 = f2 > 0.4;
% subplot(2,3,3), imshow(f2), title('smoothed');





% 2 means:
% 1: dilate, then check the points isolated even dilated;
% f2 = imdilate(f1, strel('disk', 5));
% Bdilate = bwboundaries(f2);
% lens2 = cellfun('length', Bdilate);
% subplot(2,3,3), imshow(f2), title('imfilled');

% 2: check the small connected components, according to the centroid and 
%   axes length to decide whether these points should be deleted or be 
%   jointed to a larger connected component.

f2 = f1;
rp = regionprops(f1, 'all');
count = size(rp, 1);
smallMaxFench = 40;
largeMinFench = 300;
for i=count:-1:1
    if(rp(i).Area < smallMaxFench)
        nearestDis = 10000;
        centroid = rp(i).Centroid;
        neark = -1;
        for k=count:-1:1
            if (rp(k).Area >= largeMinFench)
                distance = abs(centroid(1) - rp(k).Centroid(1)) + ...
                    abs(centroid(2) - rp(k).Centroid(2));
                if(distance < nearestDis)
                    nearestDis = distance;
                    neark = k;
                end
            end
        end
        % compare the distance and the axes length
        if nearestDis > 0.6*(rp(i).MajorAxisLength + rp(k).MajorAxisLength)
            % discard
            f2(rp(i).PixelIdxList) = 0;
        else
            
        end
    end
end

Boriginal = bwboundaries(f2);
lens1 = cellfun('length', Boriginal);

for i=1:size(lens1,1)
    num = size(Boriginal{i}, 1);
    xy1 = Boriginal{i}(1, :);
    xy2 = Boriginal{i}(num, :);
    [x, y] = intline(xy1(1), xy2(1), xy1(2), xy2(2));
    for k=1:size(x,1)
        f2(x(k), y(k)) = 1;
    end
end


% se = strel('disk', 3);
% f2 = imdilate(f2, se);
% f2 = imfill(f2, 'holes');
% f2 = imerode(f2, se);


subplot(2, 3, 3), imshow(f2);


cc = bwconncomp(f2);
L = labelmatrix(cc);
g = label2rgb(L, 'jet', [.7 .7 .7], 'shuffle');
subplot(2,3,4), imshow(g);
