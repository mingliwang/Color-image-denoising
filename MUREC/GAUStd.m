function StdGau = GAUStd(~)
%STDGAU Summary of this function goes here
%   Detailed explanation goes here


StdGau = zeros(12, 3);
a = [5 15 30 50 75 105];
for i = 1: length(a)
    StdGau(i, :) = a(i)*[1 1 1];
end
StdGau(7, :) = [40 20 30];
StdGau(8, :) = [30 10 50];
StdGau(9, :) = [5 30 15];
StdGau(10, :) = [50 75 25];
StdGau(11, :) = [75 75 30];
StdGau(12, :) = [15 105 105];
end

