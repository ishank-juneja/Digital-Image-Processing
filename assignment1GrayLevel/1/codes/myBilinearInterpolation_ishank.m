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

%For the rest of the process, for loops are best
%for ii  
    
end