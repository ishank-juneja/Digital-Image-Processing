%% Main script for HW5 Q3
% Identify and Eleminate Noise patterns using Fourier Transform

tic;
%% Load Image
path = "../data/image_low_frequency_noise.mat";
img_struct = load(path);
%The .MAT file structure parameter is Z
noisy_img = img_struct.Z;
figure('name', 'Original Image', 'Position', [0, 50, 600, 600]), imagesc(noisy_img);
imshow(noisy_img, []);


%% Prepare Image for taking FFT
%Pad by same amount along both axes 
%Since the original image is square
%Zero padding improves resolution....
row = size(noisy_img, 1);
noisy_img = padarray(noisy_img, [row/2, row/2], 'both');

%% Take Fourier Transform
noisy_fft = fft2(noisy_img);
noisy_shift = fftshift(noisy_fft);
%Take magnitude plot of FFT
mag = abs(noisy_shift);
%Ensure log is positive
noisy_log = log(mag + 1);
% Display FT
figure('name', 'Log-Magnitude-plot of FFT', 'Position', [500, 50, 600, 600]), imagesc(noisy_log);
colormap(jet);
%Type impixelinfo in terminal at this point
%Get index of center signals of pixels using plot 
% Displacement [8, 16]
noise = [267, 277; 247, 237];
%Draw circles cenetred at these locations
%viscircles does that automatically on current axes
viscircles(noise, [8; 8]);
noisy_index = sub2ind(size(noisy_fft), noise(:, 2), noise(:, 1));

%% Denoising using Notch Filter
filter = ones(size(noisy_fft));
filter(noisy_index) = 0;
%Create a disk, erode filter (Grow in 0's)
disk = strel('disk', 2);
%Pick number of iterations for which to grow dark notch
n_iter = 4;
%Grow Notch using morphological Erode
for i = 1:n_iter
    filter = imerode(filter, disk);
end
%Display Notch Filter
figure('name', 'Recovered Image', 'Position', [700, 0, 600, 600]), imshow(filter, []);
%Filter in Fourier Domain
rec = ifft2(ifftshift(noisy_shift.*filter));
%Exclude zero padding to compare with original
rec = rec(row/2 + 1:row + row/2, row/2 + 1:row + row/2);
figure('name', 'Recovered Image', 'Position', [700, 50, 600, 600]), imshow(real(rec), []);

toc;