% Outputs all unique n-order subsets Y1 of vector x.  Leftovers are stored in Y2
% Mark Ebden, August 2009
function [Y1,Y2] = subsets (x, n)

% A. Abstract the contents of x
x = sort(x);
l = length(x);
types = unique(x);
numTypes = length(types); % how many types of numbers
typeNums = zeros(1,numTypes); % how many of each type
for i=1:numTypes,
    typeNums(i) = sum(types(i)==x);
end

% B. Assume temporarily that numTypes = 4, padding with zeros
typeNums = [typeNums zeros(1,4-numTypes)];
types = [types zeros(1,4-numTypes)];

% C. Find the partitions
Y1 = []; Y2 = [];
max1 = min(n,typeNums(1));
min1 = max(0,n-sum(typeNums(2:4)));
for i1=min1:max1,
    max2 = min(n-i1,typeNums(2));
    min2 = max(0,n-sum([i1 typeNums([3:4])]));
    for i2=min2:max2,
        max3 = min(n-i1-i2,typeNums(3));
        min3 = max(0,n-sum([i1 i2 typeNums(4)]));
        for i3=min3:max3,
            i4 = n-i1-i2-i3;
            y1 = [ones(1,i1)*types(1) ones(1,i2)*types(2) ones(1,i3)*types(3) ones(1,i4)*types(4)];
            y2 = [ones(1,typeNums(1)-i1)*types(1) ones(1,typeNums(2)-i2)*types(2) ones(1,typeNums(3)-i3)*types(3) ones(1,typeNums(4)-i4)*types(4)];
            Y1 = [Y1; y1]; Y2 = [Y2; y2];
        end
    end
end