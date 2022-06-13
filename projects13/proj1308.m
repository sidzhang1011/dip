clc; clear; close all;
addpath ..;

%  (a)
lb = imread('leg_bone.tif');
subplot(2,3,1), imshow(lb);
lb = double(lb);
lbAt = imbinarize(lb);

[x1, x2] = find(lbAt);
X = [x1 x2];

P = principalComponents(X, 2);
Y = P.Y;
miny1 = min(Y(:,1));
miny2 = min(Y(:,2));
y1 = round(Y(:,1) - miny1 + min(x1));
diff = max(y1) - size(lbAt, 1);
if (diff > 0)
    y1 = y1 - diff;
end
y2 = round(Y(:,2) - miny2 + min(x2));

idx = sub2ind(size(lbAt), y1, y2);
lbout = false(size(lbAt));
lbout(idx) = 1;
subplot(2,3,2), imshow(lbout);

% (b).
lbout = imclose(lbout, ones(3));
subplot(2,3,3), imshow(lbout);
