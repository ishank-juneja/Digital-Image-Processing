function [global_mean, class_mean, X, Xn] = myImportYC_train(total_img,training,training_2)
%total_img = 39;
%training = 36 ;
%per_face = 64;
%Number of tail enteries of each person skipped in the dataset
%neg = 8;
%training_2 = 2;
X = zeros(192*168,9*training_2 + (total_img -10)*training);
Xn = zeros(192*168,9*training_2 + (total_img -10)*training);%size of one image
path = '../CroppedYale/YaleB0';
class_mean = zeros(192*168,total_img-1);
for  i = 1:1:9
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm'));
    dummy_mean = zeros(192*168,1);
    for j = 1:training
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        dummy_mean(:,1) = dummy_mean(:,1) + img(:);%for calculating the mean of class
        X(:,(i-1)*training_2 + j) = img;
        Xn(:,(i-1)*training_2 + j) = img;
    end
    class_mean(:,i) = dummy_mean/training_2;
    for j = 1:training_2
         X(:,(i-1)*training_2 + j) =  X(:,(i-1)*training_2 + j)  -     class_mean(:,i);
    end
end

path = '../CroppedYale/YaleB';

for  i = 10:1:39
    if i < 14 %14th element not present
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
    dummy_mean = zeros(192*168,1);
    for j = 1:training
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        dummy_mean(:,1) = dummy_mean(:,1) + img(:);%for calculating the mean of class
        X(:,(i-10)*training +9*training_2+ j) = img;
        Xn(:,(i-10)*training + 9*training_2+j) = img;
    end
    class_mean(:,i) = dummy_mean/training;
    for j = 1:training
        X(:,(i-10)*training +9*training_2+ j) =  X(:,(i-10)*training +9*training_2 + j)  -     class_mean(:,i);
  %  end
    end
    end
    
    if i > 14 %14th element not present
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
    dummy_mean = zeros(192*168,1);
    for j = 1:training
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        dummy_mean(:,1) = dummy_mean(:,1) + img(:);%for calculating the mean of class
        X(:,(i-11)*training+9*training_2 + j) = img;
        Xn(:,(i-11)*training+9*training_2 + j) = img;
    end
    class_mean(:,i-1) = dummy_mean/training;
    for j = 1:training
        X(:,(i-11)*training+9*training_2 + j) =  X(:,(i-11)*training+9*training_2 + j)  -     class_mean(:,i-1);
  %  end
    end
    end
    
end
global_mean = sum(transpose(class_mean))/total_img;
global_mean = transpose(global_mean);
