function [wrong] = mySVD_YALE_test(U_k, perimage, training, x_bar, alpha)
% Testing phase: test the reduced eigen space model created 

%Move to test data set images 7 -- 10 foir each person
wrong = 0;
path = '../images/CroppedYale/YaleB0';
for i = 1:9
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
    for j = training + 1:perimage
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
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
        output = floor((index-1)/40) + 1;
        if output ~= i 
            wrong = wrong + 1;
        end
    end
end

path = '../images/CroppedYale/YaleB';
for i = 10:39
   if i ~= 14 %14th person/folder not present
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
        for j = training + 1:perimage
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
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
        output = floor((index-1)/40) + 1;
        if output ~= i 
            wrong = wrong + 1;
        end
        end
   end
end
