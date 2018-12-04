%% Main script for Q1 SVD part
%Percentage accuracy displayed in the end
%Self contained script no functions called 
tic;
%% Read in images in a loop
k = 50;
%k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170]
total_img = 32;
training = 6;
perimage = 10;
N = total_img*training;
%Matrix of all images
X = zeros(112*92, 32*6);

%% Read in ORL Database
path = '../images/att_faces/s';
for i = 1:total_img
    for j = 1:training
        img = im2double(imread(strcat(path,int2str(i),'/',int2str(j),'.pgm')));
        %Convert image to dx1 clumn vector
        img = img(:);
        %Save image colyumn vector into X
        X(:,(i-1)*6 + j) = img;
     end
end
x_bar = mean(X, 2);
X = X - x_bar;

%% Get the singular Value decomposition of the matrix
%C is the covariance matrix of size dxd
%Not needed C = (X*X')/(N - 1);
%Get the SVD of X
%Get eigen vectors of matrix C = XX^T which are in U due to property of SVD
[U, S, V] = svd(X);
%Select first K cloumns of U which correspond to the top k singular values
U_k = U(:,1:k);
%Get projection of the eigen vectors on this reduced size k singular values
alpha = U_k'*X;

%% Testing phase: test the reduced eigen space model created 

%Move to test data set images 7 -- 10 foir each person
wrong = 0;
for i = 1:total_img
    for j = (training + 1):perimage
        img = im2double(imread(strcat(path,int2str(i),'/',int2str(j),'.pgm')));
        img = img(:) - x_bar;
        %Take projection of test image onto reduced eigen space
        alpha_img = U_k'*img;
        %Take difference between the reduced signatures of all
        %the training images and this test image
        error = alpha - alpha_img;
        %Compute the squared error
        error1 = error.^2;
        %Take the sum of the elements in each column as net error measure
        error2 = (sum(error1, 1)).^(0.5);
        %Pick the index of the least error
        [value, index] = min(error2);
        output = floor((index-1)/6) + 1;
        if output ~= i 
            wrong = wrong + 1;
        end
    end
end
%Percentage accuracy
accuracy = 100*(1 - wrong/((perimage-training)*32))
toc;