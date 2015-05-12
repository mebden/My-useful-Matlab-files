%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% THE DIAGNOSTIC PERFORMANCE CALCULATOR
%
% File: diagnostic_effectiveness.m
% Author: Mark Ebden
% Date: December 2004
%
% DESCRIPTION
% Inputs: a = test vector, nx1, of 0's and 1's (0 = false)
%         b = expert vector, nx1, of 0's and 1's
% Outputs: TP, TN, FN, FP (T = true, P = positive, etc.)
%          N/PPV = negative/positive predictive value
%          Sens = sensitivity
%          Spec = specificity
%          num_eval = how many points were analysed
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [TP, TN, FN, FP, PPV, NPV, Sens, Spec, num_eval] = diagnostic_effectiveness (a, b);

if size(a,1) ~= size(b,1) | size(a,2) ~= size(b,2) | size(a,2) ~= 1 | size(b,2) ~= 1,
    error ('The two input vectors must be nx1.');
end

n = length(a);
TP = 0; TN = 0; FN = 0; FP = 0;
for i = 1:n,
    if a(i) == 1,
        if b(i) == 1,
            TP = TP + 1;
        elseif b(i) == 0,
            FP = FP + 1;
        end
    elseif a(i) == 0,
        if b(i) == 0,
            TN = TN + 1;
        elseif b(i) == 1,
            FN = FN + 1;
        end
    end
end

PPV = TP/(TP+FP);
NPV = TN/(TN+FN);
Sens = TP/(TP+FN);
Spec = TN/(TN+FP);
num_eval = TP+TN+FN+FP;