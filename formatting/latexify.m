function latex_matrix = latexify(M,digitsPrec,addLines)
% Converts a matrix to Latex format
% Inputs:
%  M - the matrix
%  digitsPrec - how many significant figures to use
%  addLines - if 1, append "\hline" to each line

if nargin < 2,
    digitsPrec = 2;
end
if nargin < 3,
    addLines = 0;
end

latex_matrix = [];
for j = 1:size(M,1),
    latex_row = num2str(M(j,1),digitsPrec);
    for k = 2:size(M,2),
        latex_row = [latex_row [' & ' num2str(M(j,k),digitsPrec)]];
    end
    if j < size(M,1)
        if addLines == 1,
            latex_row = [latex_row ' \\ \hline'];
        else
            latex_row = [latex_row ' \\ '];
        end
    end
    disp(latex_row)
end