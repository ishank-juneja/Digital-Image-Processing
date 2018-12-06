function [stretched] = myLinearContrastStretching(img)
%Performs linear contrast stretching on img
min(img(:))
max(img(:))
imDouble = im2double(img);
minP = min(imDouble(:));
maxP = max(imDouble(:));
%Compute Scale factor
SF = 1/(maxP - minP);
stretched = im2uint8(SF.*imDouble);