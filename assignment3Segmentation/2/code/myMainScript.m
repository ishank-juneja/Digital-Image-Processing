%% Main prgram for Q2
%{
Program to apply Mean shift segmentation to the image Baboon.png
The image is smoothened using Gaussian convolution followed by
subsampling by 2
The algorithm used takes into account both Color and spacial coordinates
while creating segments

Iterations should be around 
%}
tic;
%% Prepare Image for segmentation
path = '../data/baboonColor.png';
baboon = imread(path, 'png');
baboon_smooth = imgaussfilt(baboon_small, 1);
%Sub sample by decimation
baboon_small = baboon(1:2:end, 1:2:end, :);

%% Perform Mean shift segmentation
%Order of parameters img, hs(space), hr(intensity), cycles
baboon_segmen = myMeanShiftSegmentation(baboon_small, 10, 2, 15);

%% Displaying Results

%figure(1), imshow(baboon);
figure(2), imshow(baboon_segmen);
%title('Output of function for the values hs = 10, hr = 1, 15 iter')
% As discussed in report, below op. are performed to see enhanced effect
rounded = round(baboon_segmen*20)/22;
figure(3), imshow(rounded);
%title('Enhanced Segmentation');
baboon = im2double(baboon);
rounded2 = round(baboon*20)/22;
figure(4), imshow(rounded2);
%title('Same enhancement applied to original');

toc;