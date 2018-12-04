function [ c ] = hist_eq_col(B  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[rows,columns,hight] = size(B);

redChannel = B(:, :, 1);
greenChannel = B(:, :, 2);
blueChannel = B(:, :, 3);
red = his_eq(redChannel);
green = his_eq(greenChannel);
blue = his_eq(blueChannel);
c(:, :, 1) = red;
c(:, :, 2) = green;
c(:, :, 3) = blue;
end

