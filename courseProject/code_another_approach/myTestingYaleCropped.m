function [wrong] = myTestingYaleCropped(V_fish, per_face, train_size, x_bar, alpha)
% Testing phase: test the reduced eigen space model created 

wrong = 0;
neg = 8;
path = '../CroppedYale/YaleB';
%Hard Code Image dimentions for the Yale Database 
for  i = 1:39
    if i == 14 %14th person not present in Dataset
        continue;
    end
    if i < 10
        D = strcat(path, '0', int2str(i));
    else 
        D = strcat(path, int2str(i));
    end
    %S is a file structure which holds folder and file names
    S = dir(fullfile(D, '*.pgm')); 
    % Due to inconsistency in total number of images of
    % each person available take per_face - neg as endpoint
    for j = train_size + 1 : per_face - neg
        %S(i).folder is a constant here since all are from same dir
        img = im2double(imread(strcat(S(i).folder, '/', S(j).name)));
        img = img(:); %- x_bar;
        alpha_img = V_fish' * img;
        %Take difference between the reduced signatures of all
        %the training images and this test image
        error = alpha - alpha_img;
        %Compute the squared error
        error1 = error.^2;
        %Take the sum of the elements in each column as net error measure
        error2 = (sum(error1, 1)).^(0.5);
        %Pick the index of the least error
        [value, index] = min(error2);
        output = floor((index-1)/train_size) + 1;
        if output ~= i 
            wrong = wrong + 1;
        end
    end
end

%% Percentage accuracy
accuracy = 100*(1 - wrong/((per_face - train_size - 8)*38)) 

end