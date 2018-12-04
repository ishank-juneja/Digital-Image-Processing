%% Main script for Q1 SVD with Yale database
%Percentage accuracy displayed in the end
tic;
%% Read in images in a loop
K = [1 2 3 5 10 15 20 30 50 60 65 75 100 200 300 500 1000];
n = size(K, 2);
total_img = 38;
%40 Training 20 Testing
training = 40;
perimage = 60;
N = total_img*training;
%Matrix of all images
X = zeros(192*168, total_img*training);

%% Read in Yale Database
%Path for images in folders B01-B09
path = '../images/CroppedYale/YaleB0';
for i = 1:9
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
        for j = 1:training
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        X(:,(i-1)*40 + j) = img;
        end
end

path = '../images/CroppedYale/YaleB';
for i = 10:39
    if i ~= 14 %14th person/folder not present
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
        for j = 1:training
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        X(:,(i-1)*40 + j) = img;
        end
    end
end
x_bar = mean(X, 2);
X = X - x_bar;

%% Get the singular Value decomposition of the matrix
    %C is the covariance matrix of size dxd
    %Not needed C = (X*X')/(N - 1);
    %Get the SVD of X
    %Get eigen vectors of matrix C = XX^T which are in U due to property of SVD
    [U, S, V] = svd(X, 'econ');

%% Plot Recognition rate vs k value
wrong = zeros(1, n);

for  i = 1:n    
    %Select first K cloumns of U which correspond to the top k singular values
    U_k = U(:,1:K(i));
    %Get projection of the eigen vectors on this reduced size k singular values
    alpha = U_k'*X;
    wrong(i) = mySVD_YALE_test(U_k, perimage, training, x_bar, alpha)/((perimage-training)*38*20);
end
acc = 1-wrong;

%% Plot the graphs

figure(1),plot(K,wrong);
xlabel('K') 
ylabel('Error Rate') 
figure(2),plot(K,acc);
xlabel('K') 
ylabel('Accuracy ') 
toc;