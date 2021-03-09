function patBankNs = im2Pats(Jm, patSize)
% IM2PATS From noisy image to patches.
%

Jm = single(Jm);
[R, C, D] = size(Jm);

% noisy image to patch bank
patBankNs = zeros((R-patSize+1)*(C-patSize+1), patSize^2, D, 'single');
for c=1: patSize
    for r=1: patSize
        tmp = Jm(r:(r+R-patSize), c:(c+C-patSize), :);
        patBankNs(:, r+(c-1)*patSize, :) = reshape(tmp, [], 1, D);
    end
end
end