function [RMSD] = myRMSD(A, B)
%Function to compute the Root Mean Squared difference
%between two images A and B of same dimension
%Inputs to the function must be of type double

%Rescale the images to account for difference in range
A = A/(max(max(A))-(min(min(A))));
B = B/(max(max(B))-(min(min(B))));

%Pointwose Difference
sub = A - B;
%Assume Square Images
N = size(sub, 1);

RMSD = sqrt(sum(sum(sub.^2)) / (N*N));

end







