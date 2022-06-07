function oc = isCodeClosed(fcc, conn)
%isCodeClosed Determines if a Freeman chain code is of a closed curve.
%   OC = isCodeClosed(FCC, CONN) determines if Freeman chain code FCC
%   corresponds to a closed curve with connectivity CONN (4 or 8, the
%   latter being the default). Output OC is 1 if the curve is closed and 0
%   otherwise.
%
%   The following table lists the changes in deltax and deltay to
%   transition from a point in the direction of the code symbol. The origin
%   is based on our image coordinate system, with the origin on the top,
%   left (see Fig. 2.1). The index is used in the body of the function to
%   determine the appropriate deltax and deltay to use from one element of
%   the code to the next.
%
%           - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%               4-code  |  8-code  |  deltax  |  deltay  |  index
%           - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%                  0         0          0          1          1
%                            1         -1          1          2
%                  1         2         -1          0          3
%                            3         -1         -1          4
%                  2         4          0         -1          5
%                            5          1         -1          6
%                  3         6          1          0          7
%                            7          1          1          8
%           - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%
%   A code is closed only if the sums of the deltax and deltay for the
%   transitions through all the symbols are both zero. You can see this by
%   noting that the sum of the deltax and deltay columns in the table are
%   zero.

if nargin == 1
    conn = 8;
end

fccsize = size(fcc);
if (fccsize(2) ~= 2)
    error('fcc should be a np-by-2 array')
end

if conn ~= 4 && conn ~= 8
    error('wrong connection')
end

% remove dup first
if (fcc(1,:) == fcc(end,:))
    fcc = fcc(1:fccsize(1) - 1, :);
end

fcc1 = circshift(fcc, -1);
delta = fcc1 - fcc;
if (min(delta(:)) ~= -1) || (max(delta(:)) ~= 1)
    oc = 0;
else
    if sum(delta(:,1)) ~= 0 || sum(delta(:,2)) ~= 0
        oc = 0;
    else
        oc = 1;
    end
end
