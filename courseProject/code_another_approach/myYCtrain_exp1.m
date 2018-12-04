function [global_mean, class_mean, X, Xn] = myYCtrain_exp1(total_img,training)
% Xn is the native images matrix while X is class mean deducted img matrix
%Formats the Cropped Yale Datbase into a single Matrix 
%Containg all the mean deducted vectors 

X = zeros(192*168,38*40);
Xn = zeros(192*168,38*40);%size of one image
path = '../CroppedYale/YaleB0';
class_mean = zeros(192*168,39);
for  i = 1:9
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm'));
    dummy_mean = zeros(192*168,1);
    for j = 1:training
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        dummy_mean(:,1) = dummy_mean(:,1) + img(:);%for calculating the mean of class
        X(:,(i-1)*training + j) = img;
        Xn(:,(i-1)*training + j) = img;
    end
    class_mean(:,i) = dummy_mean/training;
    for j = 1:training
         X(:,(i-1)*training + j) =  X(:,(i-1)*training + j)  -     class_mean(:,i);
    end
end

path = '../CroppedYale/YaleB';

for  i = 10:39
    if i ~= 14 %14th element not present
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
    dummy_mean = zeros(192*168,1);
    for j = 1:training
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        dummy_mean(:,1) = dummy_mean(:,1) + img(:);%for calculating the mean of class
        X(:,(i-1)*training + j) = img;
        Xn(:,(i-1)*training + j) = img;
    end
    class_mean(:,i) = dummy_mean/training;
    for j = 1:training
        X(:,(i-1)*training + j) =  X(:,(i-1)*training + j)  -     class_mean(:,i);
    end
    end
end
global_mean = sum(transpose(class_mean))/total_img;
global_mean = transpose(global_mean);
end