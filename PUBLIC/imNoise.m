function Jm = imNoise(Im, arg3, Pchl, noisTyp)
%IMNOISE Noise for gray/color image.
%

[R, C, D] = size(Im);

switch noisTyp
    case 'Gaussian'
        randn('seed', 0);  % rng(0, 'v4') gives same result without warning
        noise = reshape(randn([R, C, D]), [], D);
        noise = noise*Pchl';
        Jm = Im + reshape(noise*diag(arg3), [R, C, D]);
end
end
