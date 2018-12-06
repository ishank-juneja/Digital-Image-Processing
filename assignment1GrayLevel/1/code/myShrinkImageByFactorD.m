function [shrunken] = myShrinkImageByFactorD(img, d)
%Function to shrink an image by factor d
%Using Indexed assignment to select every dth 
%Pixel in both X and Y
shrunken = img(1:d:end,1:d:end);
end
