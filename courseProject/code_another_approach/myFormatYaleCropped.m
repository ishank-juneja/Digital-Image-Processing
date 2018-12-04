function X = myFormatYaleCropped(K, train_size)
%Formats the Cropped Yale Datbase into a single Matrix 
%Containg all the mean deducted vectors 
%Inputs: K = Number of Classes (Faces)
%train_size = Number of unique images of the same face
%Folders are called B0[i]

path = '../CroppedYale/YaleB';
%Hard Code Image dimentions for the Yale Database 
img_size = 192*168; 
%Matrix to Hold all images
X = zeros(img_size, K*train_size); 
for  i = 1:39
    if i == 14 %14th person not present in Dataset
        continue;
    end
    if i < 10
        D = strcat(path, '0', int2str(i));
    else 
        D = strcat(path, int2str(i));
    end
    %S is a file structure which hols folder and file names
    S = dir(fullfile(D, '*.pgm')); 
        for j = 1:train_size
        %S(i).folder is a constant here since all are from same dir
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        %Assign ID to each image read
        X(:,(i-1)*train_size + j) = img;
        end
end
end