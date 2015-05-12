% Returns the mean t of the angles in vector a (in radians)
% Optionally, returns the weighted mean, based on weights w
% Note that angle means are unusual.  e.g. mean ([0 90 90]) != 60, but 63 degrees.
% See p 31 of N.I. Fisher, Statistical analysis of circular data
function [t] = meanWeightedAngle (a, w)

a = mod(a,2*pi);
if exist('w','var') == 0,
    w = ones(size(a));
end

if ~isempty(a),
    s = sum(w.*sin(a));
    c = sum(w.*cos(a));
    r = sqrt(s^2 + c^2);
    costheta = c/r; sintheta = s/r;
    t = atan(sintheta/costheta);
    if c < 0,
        t = t + pi;
    elseif s < 0,
        t = t + 2*pi;
    end
else
    t = -1;
end