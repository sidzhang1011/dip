function [row, col] = code2coordinates(fcc)
%code2coordinates Converts a Freeman chain code to [row, col] coordinates.
%   [ROW, COL] = code2coordinates(FCC) converts the numeric symbols in an
%   8-directional, closed Freeman chain code, FC, to [ROW, COL]
%   coordinates, where ROW and COL are column vectors. Because these
%   symbols are relative to each other, the starting coordinates are
%   arbitrary. This function sets the starting coordinates so that all
%   coordinates are positive integers. The length of both ROW and COL is
%   equal to the number of symbols in FC. It is assumed that FC is an
%   8-directional chain code.

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
table = [0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1];
len = length(fcc.fcc);
row = zeros(len+1, 1);
col = zeros(len+1, 1);
fcccode = fcc.fcc;
if (max(fcccode)) < 4
    fcccode = 2 * fcccode;
end
row(1) = fcc.x0y0(1);
col(1) = fcc.x0y0(2);
row(end) = row(1);
col(end) = col(1);
for i = 2:len
    row(i) = row(i-1) + table(fcccode(i-1) + 1, 1);
    col(i) = col(i-1) + table(fcccode(i-1) + 1, 2);
end
