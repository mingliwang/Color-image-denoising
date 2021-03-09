function Jm = ALGOCNDT(Nm, stdGau, Pchl)
%ALGOCNDT Algorithm for color image denoising.
%   

Imgs.ImSize = size(Nm);

Pars = parsSet('color');  % the default paramters
Pats.refIndNbh = refeNbh(Imgs.ImSize, Pars.patSize, Pars.nbhRad, Pars.cdiPatStp, Pars.refPatStp);
[Imgs.cimTfm, Imgs.stdGlb] = clorTfmNDT(stdGau, Nm, Pchl);

isStg3 = 1;
Jm = cell(2, 1);
for stage = 1: 3
    if stage==1
        Pars.balDiv(2:3) = 0;
        Pm = reshape(reshape(Nm, [], Imgs.ImSize(3))*Imgs.cimTfm, Imgs.ImSize);
        Pats.patBankNs = im2Pats(Pm, Pars.patSize);
        Pats.simIndNbh = simiMat(Imgs.stdGlb, Pars.catNum, Pats.patBankNs, Pats.refIndNbh);
    elseif stage==2
        Pars.balDiv(2:3) = Pars.catNum;
        Qm = Pars.balCps*Um+(1-Pars.balCps)*Pm;
        Pats.simIndNbh = simiMat(0, Pars.catNum, im2Pats(Qm, Pars.patSize), Pats.refIndNbh);
    elseif stage==3
        Imgs.stdGlb = 0.1*Imgs.stdGlb;
        Pars.linEst = 'lue&mix';
        Pats.patBankNs = im2Pats(Um, Pars.patSize);
    end
    [Pats.patCumNr, Pats.prsCumNe] = MUREC(Imgs.stdGlb, Pars.linEst, Pars.balChl, Pars.balDiv, ...
        Pats.patBankNs, Pats.simIndNbh);
    Um = pats2Im(Imgs.ImSize, Pats.patCumNr, Pats.prsCumNe);
    Jm{stage} = reshape(reshape(Um, [], Imgs.ImSize(3))/Imgs.cimTfm, Imgs.ImSize);
    if (stage==2) && (~isStg3)
        break
    end
end
end
