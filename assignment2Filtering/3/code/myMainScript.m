%% Main program for Q3 
% Comment out lines to view different results, currently 
% Only Barbara for sigma = 0.5 is created
%{
Edge-preserving Smoothing using Patch-Based Filtering
Aspect Ratio 1:1
Use 9x9 patches. Use a Gaussian, or clipped Gaussian, weight function on the patches to make
the patch more isotropic (as compared to a square patch). Note: this will imply neighbor-locationweighted
distances between patches. For filtering pixel “p”, use patches centered at pixels “q”
that lie within a window of size approximately 25  25 around “p”
%}
tic;
%% Load Images Using Relative Paths
path1 = '../data/barbara.mat';
path2 = '../data/grass.png';
%path3 = '../data/grassNoisy.mat';
path4 = '../data/honeyCombReal.png';
%path5 = '../data/honeyCombReal_Noisy.mat';

barbara = load(path1);
barbara = barbara.imageOrig;
%grass = imread(path2, 'png');
%grass = im2single(grass);%Convert everything to single precesion
%grassNoisy = load(path3);
%grassNoisy = grassNoisy.imageOrig;
%honeyCombReal = imread(path4, 'png');
%honeyCombReal = im2single(honeyCombReal);
%honeyCombReal_Noisy = load(path5);
%honeyCombReal_Noisy = honeyCombReal_Noisy.imageOrig;

%% Corrupt Images with IID zero mean Gausian Noise sigma = 0.05 Intensity Range
%Generate noise and add for all images 
%Noise is a matrix of IID Gaussian Zero mean noise scaled to 5per of Range
%Rand N stand for Normal Noise
%Below approximates 5percent std deviation

noise = 0.05*(max(max(barbara))-min(min(barbara)))*randn(size(barbara,1));
barbaraN = barbara + noise;
%grass_range = max(max(grass))-min(min(grass));
%noise = (grass_range)*randn(size(grass,1))*0.05;
%grassN = grass + noise;
%noise = 0.05*(max(max(honeyCombReal))-min(min(honeyCombReal)))*randn(size(honeyCombReal,1));
%honeyCombRealN =  noise + honeyCombReal; 

%% Perform Patch Based Filtering
%grass_REC = myPatchBasedFiltering(grassN, 25, 9, 0.02);
%grass_REC1 = myPatchBasedFiltering(grassN, 25, 9, 0.01);
barbara_REC = myPatchBasedFiltering(barbaraN, 25, 9, 0.5);

%% Check RMSD values
barbaraErr = myRMSD(barbara_REC, barbara);
%grassErr1 = myRMSD(grass_REC1, grass);
%grassErr2 = myRMSD(grass_REC2, grass);
%barErr3 = myRMSD(barbara_REC3, barbara);
%grassErr = myRMSD(grass_REC, grass);
%HoneyCombErr = myRMSD(honeyCombReal_REC, honeyCombReal);

%% Display Results
figure('name', 'Grass Patch Based h = 0.05', 'Position', [100 100 1200 400])
colormap('gray');
subplot(1, 3, 1), imagesc(barbara)
subplot(1, 3, 2), imagesc(barbaraN)
subplot(1, 3, 3), imagesc(barbara_REC)

%{
figure('name', 'Barbara Patch Based h = 0.5', 'Position', [100 100 1200 400])
colormap('gray');
subplot(1, 3, 1), imagesc(barbara)
subplot(1, 3, 2), imagesc(barbaraN)
subplot(1, 3, 3), imagesc(barbara_REC1)

figure('name', 'Barbara Patch Based h = 0.4', 'Position', [100 100 1200 400])
colormap('gray');
subplot(1, 3, 1), imagesc(barbara)
subplot(1, 3, 2), imagesc(barbaraN)
subplot(1, 3, 3), imagesc(barbara_REC2)

figure('name', 'Barbara Patch Based h = 0.7', 'Position', [100 100 1200 400])
colormap('gray');
subplot(1, 3, 1), imagesc(barbara)
subplot(1, 3, 2), imagesc(barbaraN)
subplot(1, 3, 3), imagesc(barbara_REC3)

%}
%% Display isometric patches as images 

%Create gaussian filterd patches to mimic circular patches
%Use method fspecial that returns an isometric gaussian patch
sigma_patch = 5;
iso_patch = fspecial('gaussian', 9, sigma_patch);
%Clip the Gaussian Kernel
max_w = 0.75*max(max(iso_patch));
iso_patch(iso_patch > max_w) = max_w;
iso_patch = iso_patch / max(max(iso_patch));
%displayIMG(iso_patch, "Filter used to make Isometric")

%% 
toc;
