%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% File: clean_corr.m
% Author: Mark Ebden
% Date: September 2004
%
% DESCRIPTION
% Calculates sliding window pearson coefficients, by:
%  - Selecting a window of size windowsize
%  - Ensuring no NaNs exist
%  - Finding pearson's r on the middle 50%
%  - advancing by windowsize/2
%
% USAGE
% [corr_vec, I_vec, In_vec] = clean_corr (S1, S2, windowsize)
%
% S1 and S2 are columns or rows, of equal size.
% windowsize = size of segments to analyse at a time
%
% Returns I_vec, the indices to the CENTRES of the
% legitimate sections, and corr_vec, the pearson's r
% for these sections, each of size windowsize/2.
% In_vec is the discards (first column) and their NaN counts
% (second column).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [corr_vec, I_vec, In_vec] = clean_corr (S1, S2, windowsize)

N = length(S1);
num_seg = floor(N/windowsize);
threshold = round (windowsize*0.08);
corr_vec = []; I_vec = []; In_vec = [];
k = 1;

while k < num_seg,
    whole_range = round((k-1)*windowsize+1:k*windowsize);
    semi_range = whole_range(round(end/4):round(3*end/4));
    s1 = S1(whole_range); s2 = S2(whole_range);
    nan_sum = sum(isnan(s1+s2));
    wp = round((k-0.5)*windowsize);
    if nan_sum <= threshold,
        s_1 = S1(semi_range); s_2 = S2(semi_range);
        u = ~isnan(s_1+s_2); s_1 = s_1(u); s_2 = s_2(u);
        %disp([size(s_1) size(s_2)])
        temp = corrcoef(s_1,s_2);
        I_vec = [I_vec wp];
        corr_vec = [corr_vec; temp(1,2)];
    else
        In_vec = [In_vec; [wp nan_sum]];
    end
    k = k + 0.5;
end

% Testing:
if 1==0,
	windowsize = 30; t = 0:.01:100; S1 = sin(t); S2 = 2*t;
	[corr_vec, I_vec] = clean_corr (S1, S2, windowsize);
	figure; plot (t,S1); hold on; plot (t,S2,'r')
	figure; plot (t(I_vec), corr_vec)
	hold on; plot (t,S1,'k')
end