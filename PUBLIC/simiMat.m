function simIndNbh = simiMat(stdGlb, simNum, patBankNs, refIndNbh)
% SIMIMAT Match the similar patches for reference patch in neighborhood.
%

patBankNs = single(patBankNs);
if size(patBankNs, 3) > 1
    [~, prinChl] = max(sum(sum(patBankNs.^2, 1), 2));  % find principal channel
    patBankNs = patBankNs(:, :, prinChl);
end
patBankNs = patBankNs';

stdThr = 30;
if stdGlb > stdThr
    hrdThr = single(0.5);
    [U, ~] = eig(patBankNs*patBankNs');
    patBankNs = U'*patBankNs;
    shcBankNs = 1-(stdGlb^2)*((patBankNs.^(-1)).^(2));
    shcBankNs = shcBankNs.*(shcBankNs>=hrdThr);
    patBankNs = patBankNs.*shcBankNs;
end

% match patches for reference patch
cntNbhInds = single(sum(logical(refIndNbh), 2));
isLackInds = (cntNbhInds < size(refIndNbh, 2));
K = size(refIndNbh, 1);
N = min(simNum, min(cntNbhInds));
simIndNbh = zeros(K, N, 'single');
for k = 1: K
    curInds = refIndNbh(k, :);
    if isLackInds(k)
        curInds(curInds==0) = [];
    end
    L = cntNbhInds(k);
    cdiInds = curInds(2:L);
    refPat = patBankNs(:, curInds(1));
    cdiPats = patBankNs(:, cdiInds);
    
    dist = sum((cdiPats-repmat(refPat, 1, L-1)).^2, 1);
    [~, indc]= sort(dist);
    simIndNbh(k, :) = [curInds(1), cdiInds(indc(1:(N-1)))];
end
end
