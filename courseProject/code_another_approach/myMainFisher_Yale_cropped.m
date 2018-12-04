%% Main script for Face recognition test
%The below MATLAB module compares 2 well known Face recognition 
%Techniques: Eigen Faces (PCA) and Fischer Faces (LDA)
%See comments for implementation details
tic;

%% Load the Cropped Yale Database
%Number of distinct people
K = 38; 
%40 for training 24 for testing
train_size = 40;
per_face = 64;
X = myFormatYaleCropped(K, train_size);
%Store total number of pictures in N
d = size(X, 1);
N = size(X, 2);
%Global Mean of image set
global_mean = mean(X, 2);
%Mean subtracted matrix X
X_bar = X;% - global_mean;
fisher_size = 200;

%% Fisher faces step 1
%Project image set to a lower dimensioanl space using PCA so that 
%Within class scatter matrix of the reduced space S_W becomes non singular

%L is the reduced size NxN matrix
L = transpose(X_bar)*X_bar;
%Get eigen decoposition of L with N - K largest eigen vectors
[vector, values] = eigs(L, fisher_size);
%Get eigen vectors of matrix X using below trick
V = X_bar*vector;
V = normalize(V);
%A = reshape(V(:,20), [192, 168]);
%imshow(A, []);
V_PCA = V;%./norm(V);
%Get projection of the eigen vectors on this reduced fisher size eigen space
projected = V_PCA' * X_bar;
%Now use alpha for LDA instead of X
%The new projected space is 0 mean
%% Fisher faces step 2 
% Compute class wise mean and global mean in the reduced space
%class_means = zeros(fisher_size, K);
%for i = 1:K
    %class_means(:, i) = sum(projected(:,1+(i-1)*train_size: i*train_size), 2)/train_size;
%end
%New global mean in this mean subtracted reduced space is 0

%% Fisher faces step 3
%Compute S_B: Between class scatter matrix and 
%S_W: Within class scatter matrix
%S_B = zeros(fisher_size, fisher_size);
%S_W = zeros(fisher_size, fisher_size);
%for i = 1:K
    % Since Global mean is 0 u_i - u = u_i
    %S_B = S_B + train_size*(class_means(i)*class_means(i)');
    %for j = 1 + (i-1)*train_size : i*train_size
      % Compute the within class scatter of reduced space
      %S_W = S_W + (projected(j) - class_means(i))*(projected(j) - class_means(i))';  
    %end
%end     

%% Fisher faces step 4
% Solve the general EVP for S_W and S_B
%[V_FLD, D_gen] = eig(S_B, S_W);
%Take top 5 in fisher space
%V_FLD = V_FLD(:, 1:50);
%V_FLD = V_FLD./norm(V_FLD);
V_FLD = eye(fisher_size);
%Project PCA space onto fisher space
alpha = V_FLD' * projected;
%Now send these alphas to tester

%% Testing phase: Test the reduced Fisher Face model created 
%Composition of PCA and FLD for tester
V_fish = V_PCA*V_FLD;
wrong = myTestingYaleCropped(V_fish, per_face, train_size, global_mean, alpha);

toc;
