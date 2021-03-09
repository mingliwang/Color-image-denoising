function refIndNbh = refeNbh(ImSize, patSize, nbhRad, cdiPatStp, refPatStp)
%REFENBH
%

R = ImSize(1);
C = ImSize(2);

% indexes bank; sampled indexes; reference indexes
patIndBank = meshInd(R, C, patSize, 1);
cdiPatInds = meshInd(R, C, patSize, cdiPatStp);
refPatInds = meshInd(R, C, patSize, refPatStp);

% label reference and sampled patch in patch indexes bank
dim = size(patIndBank, 2);
patIndBank(:, (dim+1):(dim+2)) = false;
patIndBank(cdiPatInds(:, dim), dim+1) = true;
patIndBank(refPatInds(:, dim), dim+2) = true;
patIndBank(:, dim+1) = patIndBank(:, dim+1) | patIndBank(:, dim+2);

% search neighbor indexes of reference patch
rNbhRad = min(nbhRad, floor((R-patSize)/2));
cNbhRad = min(nbhRad, floor((C-patSize)/2));

bordIndBank = meshInd(R+2*rNbhRad, C+2*cNbhRad, patSize, 1);
bordIndMap = reshape(bordIndBank(:, 3), R+2*rNbhRad-patSize+1, []);
bordRefInds(:, 1) = refPatInds(:, 1) + rNbhRad;
bordRefInds(:, 2) = refPatInds(:, 2) + cNbhRad;
bordRefInds(:, 3) = bordRefInds(:, 1) + (bordRefInds(:, 2)-1).* size(bordIndMap, 1);

bordInitNbh = reshape(bordIndMap(1:(2*rNbhRad+1), 1:(2*cNbhRad+1)), 1, []);
bordInitNbh(:, (2*rNbhRad+1)*cNbhRad+rNbhRad+1) = [];  % delete reference index
bordRefNbh = repmat(bordInitNbh, size(bordRefInds, 1), 1)+...
    repmat(bordRefInds(:, 3)-bordRefInds(1, 3), size(bordInitNbh));

patIndMap = reshape(patIndBank(:, dim), R-patSize+1, []);  % index map of original R*C image
[M, N] = size(patIndMap);
bordIndVal = cat(1, patIndMap((1+rNbhRad+1):(1+2*rNbhRad), :), patIndMap, ...
    patIndMap((M-2*rNbhRad):(M-1-rNbhRad), :));
bordIndVal = cat(2, bordIndVal(:, (1+cNbhRad+1):(1+2*cNbhRad)), bordIndVal, ...
    bordIndVal(:, (N-2*cNbhRad):(N-1-cNbhRad)));
bordIndBV = cat(2, bordIndBank, bordIndVal(:));

refNbhInds = bordIndBV(bordRefNbh(:), 4);
if sum(patIndBank(:, dim+1))~=size(patIndBank, 1)
    refNbhInds = refNbhInds.* patIndBank(refNbhInds, dim+1);  % if not all patches
end
refNbhInds = reshape(refNbhInds, size(bordRefNbh));
refIndNbh = cat(2, refPatInds(:, dim), refNbhInds);  % first column is reference patches, the others are neighborhoods
end

function patInds = meshInd(R, C, patSize, patStep)
%MESHIND Get index map.
%   return *3 matrix (r, c, t).

% step to end
patIndR = single((1:patStep:(R-patSize+1))');
patIndC = single((1:patStep:(C-patSize+1)));
if patIndR(end) ~= R-patSize+1
    patIndR(end+1, 1) = R-patSize+1;  % step to end
end
if patIndC(end) ~= C-patSize+1
    patIndC(1, end+1) = C-patSize+1;
end

% mesh indexes
M = length(patIndR);
N = length(patIndC);
patInds(:, 1) = repmat(patIndR, N, 1);
patInds(:, 2) = reshape(repmat(patIndC, M, 1), [], 1);
patInds(:, 3) = patInds(:, 1) + (patInds(:, 2)-1).* (R-patSize+1);
end
