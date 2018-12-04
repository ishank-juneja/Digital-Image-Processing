%% Main program for Q1 Ass1

tic;
%% Load images using relative paths
path1 = '../data/circles_concentric.png';
path2 = '../data/barbaraSmall.png';
img1 = imread(path1, 'png');
img2 = imread(path2, 'png');

%% (a) Shrinking by d
displayIMG(img1, 'Original Image circles_ concentric.png')
d1 = 2;
d2 = 3;
img1_shrunk1 = myShrinkImageByFactorD(img1, d1);
displayIMG(img1_shrunk1, 'circles_ concentric.png shrunken by 2');
imwrite(img1_shrunk1, '../results/circles_shrunken1.png')
img1_shrunk2 = myShrinkImageByFactorD(img1, d2);
displayIMG(img1_shrunk2, 'circles_ concentric.png srunken by 3');
imwrite(img1_shrunk2, '../results/circles_shrunken2.png')

%% (b) Bilinear interpolation
displayIMG(img2, 'barbaraSmall.png Original')
scaleR = 3;
scaleC = 2;
scaled1 = myBilinearInterpolation(img2, 3, 2);
displayIMG(scaled1, 'barbaraSmall.png enlarged using Bilinear Interpolation');
imwrite(scaled1, '../results/barbara_bilinear.png')

%% (c) Nearest Neighbour
scaled2 = myNearestNeighbourInterpolation(img2, 3, 2);
displayIMG(scaled2, 'barbaraSmall.png enlarged with Nearest Neighbour Inter.');
imwrite(scaled2, '../results/barbara_nearest.png')

toc;