%% Main program for Q5 PCA based Denoising
% All the cases take about 5 min to run in total
tic;
%% Load images using relative paths
path1 = '../data/barbara256.png';
path2 = '../data/barbara256-part.png';
img1 = imread(path1, 'png');
img2 = imread(path2, 'png');
img1 = double(img1);
figure('name', 'Original Image', 'Position', [0, 50, 600, 600]), imagesc(img1);
imshow(img1, []);


%% Add noise to the images 
%Add zero mean Gaussian Noise with sigma = 20
noisy_img = img1 + randn(size(img1))*20;
noisy_img = max(0, noisy_img);
% RMSD with noisy image for reference
RMSD = myRMSD(noisy_img, img1);
figure('name', 'Noise Added Image', 'Position', [0, 50, 600, 600]), imagesc(noisy_img);
imshow(noisy_img, []);

%% Call PCA overlaping denoising 
denoised1 = myPCADenoising1(noisy_img);
RMSD1 = myRMSD(denoised1, noisy_img);
figure('name', 'Denoised Image Method 1', 'Position', [0, 50, 600, 600]), imagesc(denoised1);
imshow(denoised1, []);


%% PCA closest 200 neighbours denoising
denoised2 = myPCADenoising2(noisy_img, 20);
RMSD2 = myRMSD(denoised2, noisy_img);
figure('name', 'Denoised Image Metod 2', 'Position', [0, 50, 600, 600]), imagesc(denoised2);
imshow(denoised2, []);


%% Denoising the same image using Bilateral filtering -- for comparison 
[denoised3, dummy] = myBilateralFiltering(noisy_img, 17, 30, 24);
RMSD3 = myRMSD(denoised3, img1);
figure('name', 'Denoised Image Metod 3', 'Position', [0, 50, 600, 600]), imagesc(denoised3);
imshow(denoised3, []);


%% Denosiing with Method 2 for Poisson Noise Model
%Add noise to the image: Poisson Noise 
noisy_img2 = poissrnd(img1);
%RMSD of noisy image for reference
RMSD4 = myRMSD(noisy_img2, img1);
figure('name', 'Poisson Noise Added Image', 'Position', [0, 50, 600, 600]), imagesc(noisy_img2);
imshow(noisy_img2, []);
% Take square root to make noise statistics Gaussian
noisy_img2 = sqrt(noisy_img2);
denoised4 = myPCADenoising2(noisy_img2, 0.25);
denoised4 = denoised4.^2;
RMSD5 = myRMSD(denoised4, img1);
figure('name', 'Denoised Image Metod 2 Poisson Noise', 'Position', [0, 50, 600, 600]), imagesc(denoised4);
imshow(denoised4, []);

%% Add different Poisson noise to the image
noisy_img3 = poissrnd(img1/20);
%RMSD of noisy image for reference
RMSD6 = myRMSD(noisy_img3, img1);
figure('name', 'High Poisson Noise Added Image', 'Position', [0, 50, 600, 600]), imagesc(noisy_img3);
imshow(noisy_img3, []);
% Take square root to make noise statistics Gaussian
noisy_img3 = sqrt(noisy_img3);
denoised5 = myPCADenoising2(noisy_img3, 0.25);
denoised5 = denoised5.^2;
RMSD7 = myRMSD(denoised5, img1);
figure('name', 'Denoised Image Metod 2 High Poisson Noise', 'Position', [0, 50, 600, 600]), imagesc(denoised5);
imshow(denoised5, []);

toc;