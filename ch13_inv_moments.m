clc; clear; close all;

fp = imread('painting_original_padded.tif');
f = fp(85:484, 85:484);
subplot(2,3,1), imshow(fp);

ftrans = zeros(568, 568, 'uint8');
ftrans(151:550, 151:550) = f;
subplot(2,3,2), imshow(ftrans);

fhs = f(1:2:end, 1:2:end);
fhs = padarray(fhs, [184 184], 'both');
subplot(2,3,3), imshow(fhs);

fm = fliplr(f);
fmp = padarray(fm, [84 84], 'both');
subplot(2,3,4), imshow(fmp);

fr45 = imrotate(f, 45, 'bilinear');
subplot(2,3,5), imshow(fr45);
fr90 = imrotate(f, 90, 'bilinear');
fr90p = padarray(fr90, [84 84], 'both');
subplot(2,3,6), imshow(fr90p);

% phi = zeros(7,1);
% phinorm = zeros(7,1);
allf = cell(6);
allf{1} = fp;
allf{2} = ftrans; 
allf{3} = fhs;
allf{4} = fmp;
allf{5} = fr45;
allf{6} = fr90p;
format short
for i=1:6
    phi = invmoments(allf{i});
    % format short e
    % disp(phi)
    
    phinorm = -sign(phi) .* (log10(abs(phi)));
    disp(phinorm)
end



