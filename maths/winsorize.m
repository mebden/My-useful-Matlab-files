% Winsorize the data
% i.e., set the top x percentage equal to the 100-xth percentile value,
% and the bottom x percentage equal to the xth percentile value.
% Mark Ebden, December 2003.  Revised July 2013

function [data] = winsorize (data, percent)
data = data(isfinite(data));
top_perc = prctile(data, 100-percent); bottom_perc = prctile(data, percent);
data = max(min(data,top_perc),bottom_perc);

