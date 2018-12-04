function [X] = myImportYC_test(total_img,training,perimage)
%Returns the test set of images collected into matrix X

X = zeros(192*168, 38*(perimage - training  )); %size of one image
path = '../CroppedYale/YaleB0';
for  i = 1:9
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm'));
    for j = training+1:perimage        
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        X(:,(i-1)*(perimage-training) + j-training) = img;
    end
end

path = '../CroppedYale/YaleB';
for  i = 10:39
    if i < 14  %14th element not present
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
    for j = training+1:perimage
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);

        X(:,(i-1)*(perimage-training) + j-training) = img;
    end
    end
    
        if i > 14  %14th element not present
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
    for j = training+1:perimage
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);

        X(:,(i-2)*(perimage-training) + j-training) = img;
    end
    end
end
