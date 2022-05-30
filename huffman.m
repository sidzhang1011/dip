function CODE = huffman(p)
%HUFFMAN Builds a variable-length Huffman code for a symbol source.
%   CODE - HUFFMAN(P) returns a Huffman code as binary strings in cell 
%   array CODE for input symbol probability vector P. Each word in CODE 
%   corresponds to a symbol whose probability is at the corresponding 
%   index of P.

%   Based on huffman5 by Sean Danaher, University of Northumbria, 
%   Newcastle UK. Available at the MATLAB Central File Exchange: 
%   Category General DSP in Signal Processing and Communications.

% Check the input arguments for reasonableness.
narginchk(1,1);
if (~ismatrix(p)) || (min(size(p)) > 1) || ~isreal(p) || ~isnumeric(p)
    error('P must be a real numeric vector.');
end

% The CODE variable is shared with the CODE variable in the nested
% function makecode. See Chapter 3 of DIPUM3E for a discussion of nested 
% functions.
CODE = cell(length(p), 1);              % Init the global cell array

if length(p) > 1
    p = p/sum(p);
    s = reduce(p);
%     celldisp(s);
% cellplot(s);

    makecode(s, []);
else
    CODE = {'1'};
end;
    %------------------------------------------------%
    function makecode(sc, codeword)
    % Scan the nodes of a Huffman source reduction tree recursively to 
    % generate the indicated variable length code words.

        if isa(sc, 'cell')
            makecode(sc{1}, [codeword 0]);
            makecode(sc{2}, [codeword 1]);
        else
            CODE{sc} = char('0' + codeword);
        end
    end
end


% ----------------------------------------------------%
function s = reduce(p)
% Create a Huffman source reduction tree in a MATLAB cell structure 
% by performing source symbol reductions until there are only two
% reduced symbols remaining

s = cell(length(p), 1);

% Generat a starting tree with symbol nodes 1, 2, 3, ... to 
% reference the symbol probabilities.
for i = 1:length(p)
    s{i} = i; 
end
while numel(s) > 2
    [p, i] = sort(p);
    p(2) = p(1) + p(2);
    p(1) = [];

    s = s(i);
    s{2} = {s{1}, s{2}};
    s(1) = [];
end
end

