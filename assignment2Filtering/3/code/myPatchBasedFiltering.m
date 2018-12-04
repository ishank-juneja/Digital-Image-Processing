function [patch_filtered] = myPatchBasedFiltering(img, windowDim, patchDim, h)
%A function that implements patch based filtering
%Parameters that determine Gaussian Kernel are window size
%patch size and the h parameter for the Gaussian
%Window to be used is WindowDim x WindowDim

%Store Image dimension
img_dim = size(img, 1);
%Array to hold Patch weights 
%Each pixel can have upto W^2 patches 
pWeights = zeros(1, windowDim^2);
%Array to hold patch centers
pCenters = zeros(1, windowDim^2);
%Initialise return value
patch_filtered = img;

%Create gaussian filterd patches to mimic circular patches
%Use method fspecial that returns an isometric gaussian patch
sigma_patch = 5;
iso_patch = fspecial('gaussian', patchDim, sigma_patch);
%Clip the Gaussian Kernel
max_w = 0.75*max(max(iso_patch));
iso_patch(iso_patch > max_w) = max_w;
%Get dimentions
%Window Spread
WS = (windowDim - 1)/2;
%Patch Spread
PS  = (patchDim  - 1)/2;

%Outer loop iterates over rows
%We must start patch based filtering from
%index (patchWidth + 1) upto 
%dimention - patchWidth, since MATLAB
%starts indices from 1

for ii = (PS + 1):(img_dim - PS)
    %Inner loop iterates over columns
    %Go to each pixel and perform filtering
    for jj = PS+1:(img_dim - PS)
        %Create the reference patch around pixel p
        %By extracting part of original image
        refPatch = img(ii-PS:ii+PS, jj-PS:jj+PS);
        %Generate iteration Range of patches for pixel p
        startRow = max(PS+1, ii-WS);
        startCol = max(PS+1, jj-WS); 
        endRow   = min(img_dim-PS, ii+WS);
        endCol   = min(img_dim-PS, jj+WS);
        
        %Begin iterating over window
        %Associated with Pixel
        %Var to hold patch indices for a certain pixel
        pi = 0;
        for wi = startRow:endRow
            for wj = startCol:endCol            
                pi = pi + 1;
                %Create a square patch for current pixel
                patch = img(wi-PS:wi+PS, wj-PS:wj+PS);
                %Record the intensity of center pixel which will be
                %weighted later
                pCenters(pi) = img(wi, wj);
                %Compute Patch weights using gaussian on 
                %summed square values of patch vectors
                pWeights(pi) = exp(-1*sum(sum((iso_patch.*(patch-refPatch)).^2)) / h^2);
            end
        end
        %Perform Modification using Weighted sum
        %Normalise
        pWeights = pWeights / sum(pWeights);
        patch_filtered(ii, jj) = sum(pWeights.*pCenters);
    %End Inner loop
    end
%End outer loop    
end
%End function
end
