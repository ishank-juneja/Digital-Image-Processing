%% Main script for Face recognition test
%The below MATLAB module compares 2 well known Face recognition 
%Techniques: Eigen Faces (PCA) (With first 3--PCA and 
%without first 3 -- lamb) and Fischer Faces (LDA)
%See comments for implementation details
tic;

%% Import Data Set: Both training and test sets

% Total no. of classes
total_faces = 39;
training = 36 ;
per_face = 64;
%Number of tail enteries of each person skipped in the dataset
neg = 8;
[global_mean, class_mean, X, Xn] = myImportYC_train(total_faces, training);
%here X is the class mean deducted set and Xn is the original img matrix
Y = myImportYC_test(total_faces, training, per_face - neg);
% -neg as few of the classes have less image so to maintain uniformity 
class_mean = class_mean - global_mean;
% as we need class mean - global mean in Sb calculation
N = size(Xn, 2);
fisher_size = 200;

%% Fisher faces step 1
%Project image set to a lower dimensioanl space using PCA so that 
%Within class scatter matrix of the reduced space S_W becomes non singular
 
L = X' * X;
[vector, values] = eigs(L, fisher_size);%gives k largest eigen vector
V = X*vector;
V = normalize(V);
projected_set = V' * X;%projecting the data set 
test_set_proj = V' * Y;%projecting the test set
mean_proj = V' * class_mean; %projecting class mean - global mean
global_mean_proj = V' * global_mean;
V_lamb = V(:, 4:fisher_size);
test_proj_lamb = transpose( V_lamb ) * Y;
projected_set_lamb = transpose( V_lamb ) * X;

%Now use projected sets for LDA instead of X
%The new projected space is 0 mean

%% Fisher faces step 2 
%Compute S_B: Between class scatter matrix and 
%S_W: Within class scatter matrix
S_B = zeros(fisher_size, fisher_size);
S_W = zeros(fisher_size, fisher_size);

for i = 1 : total_faces
    S_B = S_B + training *(mean_proj * (mean_proj)');
end

for i = 1 : total_faces*training
    S_W = S_W +(projected_set * projected_set');
end

%% Fisher faces step 3
% Solve the general EVP for S_W and S_B

[V_fish, D_fish] = eig(S_B, S_W);
V_fish = normalize(V_fish);
%V_net = V_fish*V_fish;
%fisher_faces = reshape(V_net, 192, 168, fisher_size);
%fisher_faces = fisher_faces(:, :, 1:12);
%montage(fisher_faces);
%projecting Pca space vector in Fisher space
alpha = V_fish' * projected_set;
%Now send these alphas to tester

%% Testing phase: Test the reduced Fisher Face model created 
pos_count = per_face - neg - training;
wrongFisher_pos = zeros(1, pos_count);
wrongFisher_IDs = zeros(1, total_faces);
wrongPCA_pos = zeros(1, pos_count);
wrongPCA_IDs = zeros(1, total_faces);
wronglamb_pos = zeros(1, pos_count);
wronglamb_IDs = zeros(1, total_faces);
[row,column] = size(test_set_proj);

for i = 1 : column
        %Vanilla PCA
        img2 = test_set_proj(:, i);
        img2 = img2 - mean(img2);
        
        error_Pca = projected_set - test_set_proj(:,i);
        error1_Pca = error_Pca.^2;
        error2_Pca = (sum(error1_Pca, 1)).^(0.5);
        [value_Pca, index_Pca] = min(error2_Pca);
        output_Pca = floor((index_Pca-1)/training) + 1;
        if output_Pca ~= floor(i/(per_face - neg - training)) + 1           
            wrongPCA_pos(mod(i, 20) + 1) = wrongPCA_pos(mod(i, 20) + 1) + 1;
            wrongPCA_IDs(floor(i/20) + 1) = wrongPCA_IDs(floor(i/20) + 1) + 1;
        end
        
        %PCA without first 3 eigen vectors
        error_lamb = projected_set_lamb - test_proj_lamb(:,i);
        error1_lamb = error_lamb.^2;
        error2_lamb = (sum(error1_lamb, 1)).^(0.5);
        [value_lamb, index_lamb] = min ( error2_lamb);
        output_lamb = floor((index_lamb-1)/training) + 1;
        if output_lamb ~= floor(i/(per_face - neg - training)) + 1             
            wronglamb_pos(mod(i, 20) + 1) = wronglamb_pos(mod(i, 20) + 1) + 1;
            wronglamb_IDs(floor(i/20) + 1) = wronglamb_IDs(floor(i/20) + 1) + 1;
        end
        
        %Fisher Faces 
        alpha_img = transpose(V_fish)*img2;
        error = alpha - alpha_img;
        error1 = error.^2;
        error2 = (sum(error1, 1)).^(0.5);
        [value, index] = min ( error2);
        output = floor((index-1)/training) + 1;
        if output ~= floor(i/(per_face - neg - training)) + 1
            wrongFisher_pos(mod(i, 20) + 1) = wrongFisher_pos(mod(i, 20) + 1) + 1;
            wrongFisher_IDs(floor(i/20) + 1) = wrongFisher_IDs(floor(i/20) + 1) + 1;
        end
end

%% Classification Accuracy
acc_FLD = (1- sum(wrongFisher_IDs)/760)*100
%acc_LAMB = (1- wronglamb/760)*100
acc_PCA = (1- sum(wrongPCA_IDs)/760)*100

%% Plot Results
figure(1), plot(wrongFisher_IDs);
xlabel('Person ID') 
ylabel('F: Number of misclassifications') 
figure(2), plot(wrongFisher_pos);
xlabel('Image positions') 
ylabel('F: Number of misclassifications') 
figure(3), plot(wrongPCA_IDs);
xlabel('Person ID') 
ylabel('PCA: Number of misclassifications') 
figure(4), plot(wrongPCA_pos);
xlabel('Image positions') 
ylabel('PCA: Number of misclassifications') 
figure(5), plot(wronglamb_IDs);
xlabel('Person ID') 
ylabel('PCA(4:k) Number of misclassifications') 
figure(6), plot(wronglamb_pos);
xlabel('Image positions') 
ylabel('PCA(4:k) Number of misclassifications') 
toc;