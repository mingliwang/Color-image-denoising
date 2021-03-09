function Pchl = corrMtx(~)
%CORRMTX Define correlated matrices,
%   and return mapping matrices



K = 15;
Pchl = cell(K, 2);
Pchl{1, 1} = 'Pn';
Pchl{1, 2} = 'P';

for k = 1: K
    randn('seed', 14*(2^k))
    Porig = randn(3, 3);
    Porig = Porig./repmat(sqrt(sum(Porig.^2, 2)), 1, 3);  % FOR: .2f
    Porig = round(Porig*100)/(10);
    
    Pnorm = Porig./repmat(sqrt(sum(Porig.^2, 2)), 1, 3);
    Pchl{k+1, 1} = Pnorm;
    Pchl{k+1, 2} = Porig;
end
Pchl(5, :) = [];
Pchl(7, :) = [];
Pchl(14, :) = [];
Pchl(8, :) = [];
Pchl(5, :) = [];
Pchl(9, :) = [];
Pchl(1, :) = [];
Pchl(7, :) = [];
end

