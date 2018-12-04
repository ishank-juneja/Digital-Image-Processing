%% MyMainScript for Assignemnt 4 Q4

tic;
%% Main script to generate SVD of a Matrix

%Declare a random mxm matrix 
m = 20;
n = 6;

A = rand(m, n)
size(A)

%Get the singular decoposition 
[U,S,V] = mySVD(A);

%Verify that the matrices are the same 
%They may not be exactly the same due to limited floating point precision

recon = (U*S)*V'
size(recon)

diff = A - recon;
diff = diff.^2;

%print the value of the sum squared difference
disp(sum(sum(diff)));

toc;
