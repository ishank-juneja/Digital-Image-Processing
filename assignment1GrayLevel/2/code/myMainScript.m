%% Main Program for Q2
%Time taken 5-6 min

tic;
%% Load images using relative paths

path1 = '../data/barbara.png';
path2 = '../data/TEM.png';
path3 = '../data/canyon.png';
path4 = '../data/retina.png';
path5 = '../data/church.png'; 
path6 = '../data/retinaRef.png';
path7 = '../data/retinaMask.png';
path8 = '../data/retinaRefMask.png';

barbara = imread(path1,'png');
TEM = imread(path2,'png');
canyon = imread(path3,'png');
retina = imread(path4,'png');
church = imread(path5,'png');
ret_ref =imread(path6,'png');
ret_m=imread(path7,'png');
ret_ref_m=imread(path8,'png');

%% Linear Contrast Enhancement

%Gray Scale
linear_img1 = myLinearContrastStretching(barbara);
displayIMG(barbara, 'Original Image: Barbara');
displayIMG(linear_img1, 'Linearly Stretched : Barbara');
imwrite(linear_img1, '../results/linear_img1.png');

%Gray Scale 
linear_img2 = myLinearContrastStretching(TEM);
displayIMG(TEM, 'Original Image: TEM');
displayIMG(linear_img2, 'Linearly Stretched : TEM');
imwrite(linear_img2, '../results/linear_img2.png');

%Colored Image
linear_img3R = myLinearContrastStretching(canyon(:,:,1));
linear_img3B = myLinearContrastStretching(canyon(:,:,2));
linear_img3G = myLinearContrastStretching(canyon(:,:,3));
linear_img3 = cat(3, linear_img3R, linear_img3B, linear_img3G);
displayIMG(canyon, 'Original Image: Canyon');
displayIMG(linear_img3, 'Linearly Stretched : Canyon');
imwrite(linear_img3, '../results/linear_img3.png');

%Retina Image with MASK
%Ideally processing should happen on foregorund region only 
%But Histogram shows that ignoring backgound in 
%scaling will hardly have any effect
linear_img4R = myLinearContrastStretching(retina(:,:,1));
linear_img4B = myLinearContrastStretching(retina(:,:,2));
linear_img4G = myLinearContrastStretching(retina(:,:,3));
linear_img4 = cat(3, linear_img4R, linear_img4B, linear_img4G);
displayIMG(retina, 'Original Image: Retina');
displayIMG(linear_img4, 'Linearly Stretched : Retina');
imwrite(linear_img4, '../results/linear_img4.png');

%Church Image Colored
linear_img5R = myLinearContrastStretching(church(:,:,1));
linear_img5B = myLinearContrastStretching(church(:,:,2));
linear_img5G = myLinearContrastStretching(church(:,:,3));
linear_img5 = cat(3, linear_img5R, linear_img5B, linear_img5G);
displayIMG(church, 'Original Image: Church');
displayIMG(linear_img5, 'Linearly Stretched : Church');
imwrite(linear_img5, '../results/linear_img5.png');

%% Histogram Equalization 

bar_hiseq = myHE(barbara);
TEM_hiseq = myHE(TEM);
canyon_hiseq = myHE_col(canyon);
retina_hiseq = myHE_col(retina);
church_hiseq = myHE_col(church);

figure, imshow(bar_hiseq);
title('Histogram Equalization : Barbara');
figure, imshow(TEM_hiseq);
title('Histogram Equalization : TEM');
figure, imshow(canyon_hiseq);
title('Histogram Equalization : Canyon');
figure, imshow(retina_hiseq);
title('Histogram Equalization : retina');
figure, imshow(church_hiseq);
title('Histogram Equalization : Church');

%% Histogram matching
retina_hist_mat = myHM(retina,ret_ref,ret_m,ret_ref_m);
figure,imshow(retina_hist_mat);
title('Histogram Matched');
figure,imshow(retina);
title('Original Image Histogram Matching');
figure,imshow(ret_ref);
title('Referenced Image Histogram Matching');

%% AHE : Adaptive Histogram Equalization
%w = 25% window size = 2*w+1

barbara_AHE = myAHE(barbara,50);
figure,imshow(barbara_AHE);
title('Barbara AHE');

TEM_AHE= myAHE(TEM,30);
figure,imshow(TEM_AHE);
title('TEM AHE');

redChannel = canyon(:, :, 1);
greenChannel = canyon(:, :, 2);
blueChannel = canyon(:, :, 3);
red_ahe = myAHE(redChannel,20);
green_ahe = myAHE(greenChannel,20);
blue_ahe = myAHE(blueChannel,20);


canyan_Ahe(:, :, 1) = red_ahe;
canyan_Ahe(:, :, 2) = green_ahe;
canyan_Ahe(:, :, 3) = blue_ahe;

figure,imshow(canyan_Ahe);
title('Canyon AHE');

%% CLAHE : Contrast Limited AHE 
%w = 25% window size = 2*w+1

TEM_CLAHE= myCLAHE(TEM,30,3900);
figure,imshow(TEM_CLAHE);
title('TEM CLAHE');

barbara_CLAHE= myCLAHE(barbara,40,1300);
figure,imshow(barbara_CLAHE);
title('barbara CLAHE');

red_clahe = myCLAHE(redChannel,20,2500);
green_clahe = myCLAHE(greenChannel,20,2500);
blue_clahe = myCLAHE(blueChannel,20,2500);

canyan_clAhe(:, :, 1) = red_clahe;
canyan_clAhe(:, :, 2) = green_clahe;
canyan_clAhe(:, :, 3) = blue_clahe;
figure,imshow(canyan_clAhe);
title('Canyan CLAHE');
%% 
toc;