function [ c ] = myHE_col(B  )
%Color version of myHE 
%Performs Global Histogram Equalization

[rows,columns,hight] = size(B);

redChannel = B(:, :, 1);
greenChannel = B(:, :, 2);
blueChannel = B(:, :, 3);
red = myHE(redChannel);
green = myHE(greenChannel);
blue = myHE(blueChannel);
c(:, :, 1) = red;
c(:, :, 2) = green;
c(:, :, 3) = blue;
end

