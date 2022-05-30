function g = movingaveragethresh(f, n, K)
%MOVINGAVERAGETHRESH Image segmentation using a moving average threshold.
%   G = MOVINGAVERAGETHRESH(F,n,K) segments image F by thresholding its
%   intensities based on the moving average of the intensities along 
%   individual rows of the image. The average at pixel k is formed by 
%   averaging the intensities of that pixel and its n - 1 preceding
%   neighbors using Eq. (11-23). To reduce shadingbias, the scanning is  
%   done in azig-zag manner, treating the pixels as if they were a 1-D,
%   continuous stream. If the value of the image at a point exceeds K 
%   percent of the value of the running average at that point, a 1 is 
%   output in that location in G. Otherwise a 0 is output. At the end of
%   the procedure, G is thus the thresholded (segmented) image. K is a 
%   scalar in the range [0,1]. 

narginchk(3, 3);

if (ndims(f) ~= 2)
     error('f should be 2-d image');
end

f = double(f);
[rows, columns] = size(f);
mk = double(zeros(rows, columns));
zs = zeros(n, 1);
zIndex = 1;
currZig = 0;
countOfcurrZig = 0;
lastmk = 0.0;
r = 1;
c = 1;
shouldIncColumn = true;

% td = zeros(rows*columns , 1);
% i = 1;

% begin big cycle
while r <= rows && c <= columns
    % eq 11-23
    mk(r, c) = lastmk + (f(r,c) - zs(zIndex))/n; 

%     td(i) = f(r,c);
%     i = i+1;
    
    % save some state
    lastmk = mk(r, c);
    zs(zIndex) = f(r, c);
    zIndex = zIndex + 1;
    if zIndex > n
        zIndex = 1;
    end

    if r+c == currZig
        countOfcurrZig = countOfcurrZig + 1;
    else
        currZig = r + c;
        countOfcurrZig = 1;
    end

    if r > 1 && r < rows && c > 1 && c < columns
        [r,c] = normalChange(shouldIncColumn, r, c);
    elseif r == 1 && c == 1
        c = 2;
        shouldIncColumn = false;
    elseif r == 1 || r == rows        
        shouldIncColumn = (r == rows);
        if countOfcurrZig > 1
           if c < columns
               c = c + 1;
           else
               r = r + 1;
           end
        else
            [r, c] = normalChange(shouldIncColumn, r, c);
        end
    elseif c == 1 || c == columns
        shouldIncColumn = (c == 1);
        if countOfcurrZig > 1
            if r < rows
                r = r + 1;
            else
                c = c + 1;
            end
        else
            [r,c] = normalChange(shouldIncColumn, r, c)
        end
        
    end
end
g = f > mk*K;


function [row,col] = normalChange(incColumn, r, c)
if incColumn
    col = c + 1;
    row = r - 1;        
else        
    col = c - 1;
    row = r + 1;
end



 