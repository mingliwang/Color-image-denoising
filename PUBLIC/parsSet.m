function  Pars = parsSet(chroma)
%PARSSET Set parameters.
%

% refeNbh.m parameters
Pars.patSize = 8;
Pars.nbhRad = 19;  % nbhPats = (2*nbhRad+1)^2
Pars.cdiPatStp = 1;  % step of candidate pathes, cdiPatStp<=patSize
Pars.refPatStp = 3;  % step of reference patches

% simiMat.m parameter
Pars.catNum = 64;

% MUREC.m parameters
Pars.linEst = 'lue&bnr';
switch chroma
    case 'color'
        Pars.balChl = [3; 1; 1];
end
Pars.balDiv = 112;

% image composition parameter
Pars.balCps = 0.7;
end
