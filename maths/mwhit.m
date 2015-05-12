%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% HELP ON THE MWHIT FUNCTION
%
% File: mwhit.m
% Author: Mark Ebden
% Date: 5 May, 2003
%
% DESCRIPTION
% Calculates Mann Whitney U for two samples.
%
% USAGE
% Usage is as follows at the Matlab prompt:
%    [Ux, U] = mwhit (all_pats, classes)
% where:
%   - all_pats is a column vector with your data
%   - classes is an equally sized vector containing
%     your classification of the data (eg, 1's and 0's)
%   - U is the 2x1 vector of possible U values
%   - Ux is the true U value for use in the statistical test
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Ux, U] = mwhit (all_pats, classes)

% 1. Rank the values in ascending order
N = length(classes);
n2 = sum(classes);
n1 = N - n2;
ranked = sortrows ([all_pats classes]);
rm = [zeros(N,1) ranked];
for i = 1:N,
    rm(i,1) = i;
end

% 2. Take care of tied values
i = 2;
while i <= N,
    saved_i = i;
    while (i<=N & rm(i,2) == rm(i-1,2)),
        % A tie has occurred
        i = i + 1;
    end
    tied = i - saved_i;
    mean_value = mean(rm(saved_i-1:(saved_i+tied-1),1));
    if tied > 0,
        for row_place = saved_i-1:saved_i+tied-1,
           rm(row_place,1) = mean_value;
        end
    end
    i = i + 1;
end

% 3. Sum the ranks individually
sum_n1 = 0; sum_n2 = 0;
for i = 1:N,
    if rm(i,3) == 0,
        sum_n1 = sum_n1 + rm(i,1);
    elseif rm(i,3) == 1,
        sum_n2 = sum_n2 + rm(i,1);
    end
end

% Calculate U
if sum_n1 > sum_n2,
    nx = n1; Tx = sum_n1;
elseif sum_n1 < sum_n2,
    nx = n2; Tx = sum_n2;
else
    error ('nx error');
end

Ux = n1 * n2 + (nx * (nx + 1))/2 - Tx;
U1 = n1 * n2 + (n1 * (n1 + 1))/2 - sum_n1;
U2 = n1 * n2 + (n2 * (n2 + 1))/2 - sum_n2;
U = [U1; U2];