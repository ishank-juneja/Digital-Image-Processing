function [denoised] = myPCADenoising2(img, sigma)
%Function to implement PCA denoising with
%K Most Similar pacthes chosen from a window 

%% Divide the entire image into patches of size 7 x 7 
%and collect them into P matrix

%patch size used 
patchDim = 7;
%Patch Size
PS  = (patchDim  - 1)/2;
%Noise sigma 
%sigma = 20;
%Window Size 
win_size = 31;
%Window Spread
WS = (win_size - 1)/2;
%Number of Similar Patches to consider 
K = 200;

%% Pad image so that maximal number of 
%reference patches of sixe pacthDim can be considered
%Pad with infinity so that we can iterate over these false regions 
%Without worrying about whether they will become [art of Qi
img_padded = padarray(img, [WS, WS], inf, 'both'); 
img_dim = size(img_padded, 1);
%Initialise Matrix to hold K rolled out patches
%Q =  zeros(patchDim^2, K);
%Find Number of unique patches
%Small n is the number of iterations of outer loop 
n = (win_size - 2*PS);
N = n^2;
%Declare Matrix to hold all possible patches in Window 
%We will pick out the K closest from this Matrix and put in Q
P = zeros(patchDim^2, N);
%To hold MSE values of all prospective patches 
MSE = zeros(1, N);
%To hold final Denoised Image 
denoised = zeros(img_dim);
%To hold the divide value at each pixel
%The number of contributions it receives 
cont_pixel = denoised;

%% Populate P and Q
%Outer loop iterates over rows
%The references patches P_i start from ... (Since we have performed padding) 
%index (patchWidth + 1) upto dimention - patchWidth

for ii = (WS+ PS + 1):(img_dim - PS - WS)
    %Inner loop iterates over columns
    %Go to each pixel and create a reference patch centered about it
    for jj = (WS+ PS + 1):(img_dim - PS - WS)
        %Create the required patch centered around current pixel p
        patch = img_padded(ii-PS:ii+PS, jj-PS:jj+PS);
        %Roll out the reference patch and preserve for MSE 
        ref_patch = patch(:);
        ctr = 0;
        
        %Iterate over center pixels of prospective 
        %neighbour patches within limits of window
        for i2 = (ii - PS) - (WS - PS):(ii - PS) + (WS - PS)
            for j2 = (jj - PS) - (WS - PS):(jj - PS) + (WS - PS)
                ctr = ctr + 1;
                patch_i = img_padded(i2-PS:i2+PS, j2-PS:j2+PS);
                P(:,ctr) = patch_i(:);
            end
        end
        
        %For each column in P compute MSE with ref_patch and store in 
        %the vector MSE
        P_diff = bsxfun(@minus, P, ref_patch);
        MSE = sum(P_diff.^2,1);
        %Val holds the MSE values in ascending order 
        %Order is a permutation object
        [val, reorder] = sort(MSE);
        %At this point, some of the patches will have 
        %Mse as Infinity, we must check if there are atleast 200 valid 
        %Neighbour patches, else the eigen space we create will be wrong
        genuine_vals = sum(val < inf);
        K_new = min(200, genuine_vals - 1);
        P = P(:,reorder);
        %Q contains atmost 200 closest patches 
        Q = P(:,2:K_new + 1);
        %Compute the Covariance Matrix since D = 49 is not large 
        %C is a 49x49 sized Matrix 
        C = Q * Q';
        %Get normalized orthogonal eigen vectors v and eigen values (Not used)
        [V, D] = eig(C);
        %Get noisy coeficients of original patch in this basis
        %These need to be updated
        alpha_noisy = V' * ref_patch;
        %Get the coeffcients of this space, these will be used in the 
        %Estimate of the denoised values of alpha
        alpha_all = V' * Q;
        %Get a 49 x 1 vector of mean alpha values
        %Take average sum squared of values across columns
        %An estimate of the original noiseless eigen coefficients
        h_sum = sum(alpha_all .^ 2, 2);
        %h_sum is a column vector 
        estimate = h_sum*1/K_new - sigma^2;
        alpha = max(0, estimate);
        % Generate denoised coefficients
        SNR = alpha / sigma^2;
        denom = 1 + 1./SNR;
        alpha_denoised = alpha_noisy ./ denom;
        %Recover Patch P
        ref_rec = V * alpha_denoised;
        %Add contribution from patch to concerned pixels 
        %Previous Value  + Column of Denoised patches converted to matrix
        denoised(ii-PS:ii+PS, jj-PS:jj+PS) = ...
        denoised(ii-PS:ii+PS, jj-PS:jj+PS) + reshape(ref_rec, [7, 7]);
        %Update number of contributors
        cont_pixel(ii-PS:ii+PS, jj-PS:jj+PS) = cont_pixel(ii-PS:ii+PS, jj-PS:jj+PS) + 1;
    %End Inner loop
    end
%End outer loop    
end 

%Divide the value at each pixel by number of contributors 
%denoised
denoised = denoised./cont_pixel;
denoised = denoised(WS + 1: img_dim - WS, WS + 1: img_dim - WS);

%End Function 
end