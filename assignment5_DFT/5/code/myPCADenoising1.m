function [denoised] = myPCADenoising1(img)
%Function to implement PCA denoising with
%Overlapping Patches

%% Divide the entire image into patches of size 7 x 7 
%and collect them into P matrix

%patch size used 
patchDim = 7;
%Patch Size
PS  = (patchDim  - 1)/2;
img_dim = size(img, 1);
%Noise sigma 
sigma = 20;

%% Initialise Matrix to hold rolled out patches
%Find Number of unique patches
%Small n is the number of iterations of outer loop 
n = (img_dim - 2*PS);
N = n^2;
%Patch Matrix
P = zeros(49, N);

%% Populate P 
%Outer loop iterates over rows
%We must start making overlapping patches
%from index (patchWidth + 1) upto dimention - patchWidth
ctr = 0;
for ii = (PS + 1):(img_dim - PS)
    %Inner loop iterates over columns
    %Go to each pixel and create a patch centered about it
    for jj = (PS+1):(img_dim - PS)
        ctr = ctr + 1;
        %Create the required patch centered around current pixel p
        patch = img(ii-PS:ii+PS, jj-PS:jj+PS);
        %Map 49x1 Matrix to a column of P
        P(:, ctr) = patch(:);
    %End Inner loop
    end
%End outer loop    
end 

%% Compute the Eigen Coefficents of the Patches using P

%Compute the Covariance Matrix since D = 49 is not large 
%C is a 49x49 sized Matrix 
C = P * P';
%Get normalized orthogonal eigen vectors v and eigen values (Not used)
[V, D] = eig(C);
alpha_noisy = V' * P;

%% Get a 49 x 1 vector of mean alpha values
%Take average sum squared of values across columns
%An estimate of the original noiseless eigen coefficients
h_sum = sum(alpha_noisy .^ 2, 2);
%h_sum is a column vector 
estimate = h_sum*1/N - sigma^2;
alpha = max(0, estimate);

%% Generate denoised coefficients
SNR = alpha / sigma^2;
denom = 1 + 1./SNR;
alpha_denoised = alpha_noisy ./ denom;

%% Recover image and return 
P_rec = V * alpha_denoised;
denoised = zeros(size(img));
% Keeps track of the number of contibutors to current pixel
cont_pixel = denoised;
% Reconstruction Loop
ctr = 0;
for ii = (PS + 1):(img_dim - PS)
    %Inner loop iterates over columns
    %Go to each pixel and create a patch centered about it
    for jj = (PS+1):(img_dim - PS)
        ctr = ctr + 1;
        %Add contribution from patch to concerned pixels 
        %Previous Value  + Column of Denoised patches converted to matrix
        denoised(ii-PS:ii+PS, jj-PS:jj+PS) = ...
        denoised(ii-PS:ii+PS, jj-PS:jj+PS) + reshape(P_rec(:,ctr), [7, 7]);
        %Update number of contributors
        cont_pixel(ii-PS:ii+PS, jj-PS:jj+PS) = cont_pixel(ii-PS:ii+PS, jj-PS:jj+PS) + 1;
    %End Inner loop
    end
%End outer loop    
end

%Divide the value at each pixel by number of contributors 
%denoised
denoised = denoised./cont_pixel;

%End Function 
end