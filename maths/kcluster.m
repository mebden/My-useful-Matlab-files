%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% HELP ON THE kcluster FUNCTION
%
% File: kcluster.m
% Author: Mark Ebden
% Date: April 2005
%
% DESCRIPTION
% For m observations of d-dimensional data, in an mxd
% matrix 'data', n clusters are created. Their
% 'centres' are returned, along with the classification
% results 'classes' and the minimum Euclidean-distance
% based error 'E'.  If graphing > 0 and d is 2 or 3,
% the results are plotted.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [centres, classes, E] = kcluster (data, n, graphing)

if exist('graphing') == 0,
    graphing = 0;
end
d = size(data,2);

opt_vect = zeros(1,18);
opt_vect(2:3) = 1e-4;
opt_vect(4)   = 1e-6;
opt_vect(16)  = 1e-8;
opt_vect(17)  = 0.1;
%opt_vect(1) = -1; % Turn off messages
opt_vect(14) = 100;

E = 1e50; classes = []; e1 = 1e40;
u = zeros(d,1); v = u;
for k = 1:d,
    u(k) = min(data(:,k));
    v(k) = max(data(:,k));
end
count = 0; Ecount = 0;

c = [];
while count - Ecount < 300,
    for i = 1:n,
        for k = 1:d,
            c(i,k) = rand(1)*(v(k)-u(k))+u(k);
        end
    end
    [c, E0, post, errlog] = kmeans(c,data,opt_vect);
    if E0(8) < E,
        e1 = E; E = E0(8); classes = post;
        disp(E)
        centres = c;
        Ecount = count;
    end
    count = count + 1;
end


if d < 4,
    figure; hold on
end
if 2 == d,
    plot (data(:,1),data(:,2),'.');
    plot (centres(:,1),centres(:,2),'or');
elseif 3 == d,
    plot3 (data(:,1),data(:,2),data(:,3),'.'); view(3)
    plot3 (centres(:,1),centres(:,2),centres(:,3),'or');
end