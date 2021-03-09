function Im = pats2Im(ImSize, patCumNr, prsCumNe)
% PATS2IM Patches to image, aggregation.
%

R = ImSize(1);
C = ImSize(2);
D = size(patCumNr, 3);
patSize = sqrt(size(patCumNr, 2));

% patches --> image
imCumNr = zeros(R, C, D, 'single');  % fragments to image
prsNrmNe = zeros(R, C, D, 'single');
for j = 1: patSize
    for i = 1: patSize
        imCumNr(i: (i+R-patSize), j: (j+C-patSize), :) = ...
            imCumNr(i: (i+R-patSize), j: (j+C-patSize), :) + ...
            reshape(patCumNr(:, i+(j-1)*patSize, :), R-patSize+1, [], D);
        prsNrmNe(i: (i+R-patSize), j: (j+C-patSize), :) = ...
            prsNrmNe(i: (i+R-patSize), j: (j+C-patSize), :) + ...
            reshape(prsCumNe, R-patSize+1, [], D);
    end
end
Im = imCumNr./prsNrmNe;
end
