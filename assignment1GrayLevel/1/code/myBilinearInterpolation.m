function [scaled] = myBilinearInterpolation(img, scaleR, scaleC)

%Function to scale an image by scaleR vertically and scaleC horizontally
%Starting we M rows/columns we get scale*M - (scale-1) rows/columns
M = size(img, 1);
N = size(img, 2);
rows = M*scaleR - (scaleR - 1);
cols = N*scaleC - (scaleC - 1);
scaled = zeros(rows, cols);
scaled = cast(scaled, class(img));
%Filling in the existing pixels
%Using Index assignment
scaled(1:scaleR:end, 1:scaleC:end) = img;

%% For the rest of the process, for loops are best

%Begin Interpolation

%Handling The boundary pixels sperately
for i= 1:3:rows
    for j=2:2:cols
        scaled(i,j)=double(0.5*(scaled(i,j-1))+0.5*scaled(i,j+1));
    end
    j=1;
end

%Coefficients come from scale factor
%Bilinear Interpolation for the Bulk
for i= 2:3:rows
    for j=1:1:cols
        scaled(i,j)=double((0.666* scaled(i-1,j))+ (0.333 * scaled(i+2,j)));
        scaled(i+1,j)=double((0.666* scaled(i+2,j))+ (0.333 * scaled(i-1,j)));
    end
    j=1;
end

%Convert back to uint8
%Line removed since prof has 
%Asked to keep float whenever possible
%scaled=uint8(scaled);
end