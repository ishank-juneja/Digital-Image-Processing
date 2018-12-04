function [segmented] = myMeanShiftSegmentation(img, hs, hr, cycles)
%A function to implement Mean Shift Segmentation
%img is the input image, hs is the Bandwidth of the spacial feature kernel
%hr is the Bandwidth of the Color feature kernel
%cycles is the number of iterations for which algo runs

%Convert image to real numbers to apply Kernels
img = im2double(img);

%Algo idea: Cluster pixels, replace each pixel with the mean value of its
%cluster. Repeat process everal times 
%Clustering happens 

rows = size(img, 1);
cols = size(img, 2);

%Create spatial kernel with window size dependant on the spatial Bandwidth
%ie the Spatial std. deviation, pick odd dimension for window
sKernel = fspecial('gaussian', 6*hs + 1, hs);
%Initialise Output image
segmented = img;
%Pad the image with zeroes so that spacial windows fit perfectly starting row 1 
img = padarray(img, [3*hs, 3*hs]);

%Iterate over all clusters cycles no. of times 
%There are no clusters (or size 1) pixels dusring iteration 1
for kk = 1:cycles
    %Two for loops for iterating over all pixels (non-padding)
    for ii = 3*hs+1 : rows + 3*hs
        for jj = 3*hs+1 : cols + 3*hs
            %Take out a patch based on spacial kernel
            %Extract All 3 frames of the Spatial Window 
            %The elements of this patch are the 'features'
            patch = img(ii-3*hs:ii+3*hs, jj-3*hs:jj+3*hs, 1:3);
            %Extract the RGB tuple associated with this Center pixel
            intenV = segmented(ii-3*hs, jj-3*hs,:);
            %Create an array of deviation of features of window from center
            intenMSE = (patch - intenV).^2;
            %Make a gaussian Kernel out of this
            rKernel = exp(-1.*sum(intenMSE,3)./hr^2);
            %Perform pointwise multiplication to get combined kernel
            ker = rKernel.*sKernel;
            %Get 3 dimentional version
            ker3dim = cat(3, ker, ker, ker);
            %Apply kernel to this patch
            kerPatch = patch.*ker3dim;
            %Add The elements of each frame to get an updated pixel value 
            %For each frame then normalise the value by dividing by sum ker
            %elements
            %Get valid elements of ker for correct scaling
            ker_corr = ker(max(1, 6*hs+2-ii):min(end, rows+6*hs+1-ii), max(1, 6*hs+2-jj):min(end, cols+6*hs+1-jj));
            new_intenV = sum(reshape(kerPatch, [], 3))/sum(ker_corr(:));
            %updated values of pixel taken from its neighberhood
            segmented(ii-3*hs, jj-3*hs, :) = new_intenV;
        end%Inner loop
    end%Outer loop
end%Cycles

%End function
end


