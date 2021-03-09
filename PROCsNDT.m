function PROCsNDT(p)

%clear; %close all; %clc
for t = 1: 30
    maxNumCompThreads(1);
end
addpath(genpath(sprintf('%s', pwd)))

% read image's name
imTypPng = dir('ImgSet/Kodim/*.png');
List = length(imTypPng);
ImSet = cell(List+1, 6);
ImSet{1, 1} = 'Image';
ImSet{1, 2} = 'STD';
ImSet{1, 3} = 'Denoised';
ImSet{1, 4} = 'Time(s)';
ImSet{1, 5} = 'PSIM';
ImSet{1, 6} = 'NsMapping';
lst = 2;
for i = 1: length(imTypPng)
    ImSet{lst, 1} = imTypPng(i).name;
    lst = lst+1;
end

% process the image set
Pchl = corrMtx([]);
ImSet{2, 6} = Pchl{p, 2};
ImSet{3, 6} = Pchl{p, 1};
Pchl = Pchl{p, 1};
STDGAU = GAUStd([]);
for k = 1: length(STDGAU)
    stdGau = STDGAU(k, :);
    for lst = (1+1): (List+1)
        % images reading
        Im = double(imread(ImSet{lst, 1}));
        
        % noisy images
        Nm = imNoise(Im, stdGau, Pchl, 'Gaussian');
        
        % the algorithm
        tic; Jm = ALGOCNDT(Nm, stdGau, Pchl); tim = toc;
        PSIM = [psnr(uint8(Jm{end}), uint8(Im)), ssim(uint8(Jm{end}), uint8(Im))];
        
        % record results
        ImSet{lst, 2} = stdGau;
        ImSet{lst, 3} = Jm{end};
        ImSet{lst, 4} = tim;
        ImSet{lst, 5} = PSIM;
    end
    save(sprintf('Records/MURENDTCorNs%d_Kod%d_%d_%d.mat', p, stdGau(1), stdGau(2), stdGau(3)), 'ImSet')
end
end
