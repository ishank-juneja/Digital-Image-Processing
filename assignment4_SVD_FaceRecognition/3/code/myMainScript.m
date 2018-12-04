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
%TO keep track of max error
max_error = zeros(1, total_img);
err = zeros(112*92, 1);

%% Read in ORL Database
path = '../images/att_faces/s';
for i = 1:total_img
    %Inside the inner loop maintaion state for all the images of a person
    % and in the end associate an error value with it
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
%Process the last 6 columns of X
for i = 1:total_img
    current = alpha(:, (i-1)*6 + 1:(i-1)*6 + 6);    
    for w = 1:5
        for x = w+1:6
            err = alpha(:, w) - alpha(:, x);
            err = err.^2;
            err2 = (sum(err, 1)).^(0.5);
            if(err2 > max_error(i))
                max_error(i) = err2;
            end
        end
    end
end

%% Better Implementation
%The above technique of looking for Maximum Error is not 
% robust to outliers. Since the maximum error between 2 pictures of the
% same person will be quite high, there will be no false positives 
% But at the same time, the number of false negatives will be really high
%% Testing phase: Checking for false positives and negatives
false_pos = 0;
false_neg = 0;

% Check for false positives 
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
        index_2 = floor((index-1)/6) + 1;
        %If the best match error is more than the max permissible error 
        %Then we will reject it even though test image --> False Positive
        if(max_error(index_2)*0.5 < value)
            false_pos = false_pos + 1; 
        end
     end
end
% Check for false negatives
for i = total_img + 1:40
    for j = 1:perimage
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
        index_2 = floor((index-1)/6) + 1;
        %If the best match error is less than thresh, then this
        %Case of no matching identity will not be detected
        if(max_error(index_2)*0.5 > value)
            false_neg = false_neg + 1; 
        end
     end
end 
toc;