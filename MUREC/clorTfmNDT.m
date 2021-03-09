function [cimTfm, stdGlb] = clorTfmNDT(stdGau, Jm, Pchl)
%CLORTFM
%


stdGlb = min(single(stdGau));
stdTfm = stdGlb*diag(stdGau)^(-1);

% color space transformation matrix
stdTfm = stdTfm/(Pchl');
[~, ~, D] = size(Jm);
Jc = reshape(Jm, [], D)*stdTfm;
[clrTfm, ~] = eig(Jc'*Jc);  % PCA; clrTfm=DCT is better if Pchl=I & stdGau(1)=stdGau(2)=stdGau(3)
clrTfm = flip(clrTfm, 2);

% color image transformation matrix
cimTfm = single(stdTfm*clrTfm);
end
