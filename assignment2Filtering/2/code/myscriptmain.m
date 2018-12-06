I1 = '/Users/deveshkumar/Downloads/assignmentFiltering/2/data/honeyCombReal.png';
I2 = '/Users/deveshkumar/Downloads/assignmentFiltering/2/data/grass.png';
I3 = load('/Users/deveshkumar/Downloads/assignmentFiltering/2/data/barbara.mat');
I4 = load('/Users/deveshkumar/Downloads/assignmentFiltering/2/data/honeyCombReal_Noisy.mat');
I5 = load('/Users/deveshkumar/Downloads/assignmentFiltering/2/data/grassNoisy.mat');

barbara_org = I3.imageOrig;
noise = randn(size(barbara_org, 1)) * 0.05 * max(barbara_org(:));
barbara = max(0, barbara_org+noise);
honeyCombReal_Noisy = I4.imgCorrupt;
grassNoisy = I5.imgCorrupt;
%imgn = max(0, img+noise);

honey_real = imread(I1,'png');
grass_real = imread(I2,'png');
[honey_filtered,honey_gauss] = myBilateralFiltering(honeyCombReal_Noisy,4,0.18,0.5);
[grass_filtered,grass_gauss]= myBilateralFiltering(grassNoisy,4,0.4,0.5);
[barbara_filtered,barbara_gauss] = myBilateralFiltering(barbara,13,10,6);
% the mat  files that i have that sir included should be opened with
% corresponding file name
figure(1),imshow(I2);
title('grass original');
figure(2),imshow(grassNoisy);
title('grass noisy');
figure(3),imshow(grass_filtered);
title('grass filtered');
figure(4),imshow(honeyCombReal_Noisy);
title('honeyComb noisy');
figure(5),imshow(honey_filtered);
title('honeyComb filtered');
figure(6),imshow(I1);
title('honeyComb original');
rmsd_honey = rmsd(honey_real,honey_filtered);
rmsd_grass = rmsd(grass_real,grass_filtered);
rmsd_barbara = rmsd(barbara_org,barbara_filtered);
%barbara = double(barbara);

%i converted to barbara to uint as it was showing white screen when i was
%giving it double value
barbara = uint8(barbara);
barbara_org = uint8(barbara_org);
barbara_filtered = uint8(barbara_filtered);


figure(7),imshow(barbara_filtered);
title('barbara filtered');
figure(8),imshow(barbara);
title('barbara noise');

figure(14),imshow(barbara_org);
title('barbara org');


grass_gauss = uint8(255 * mat2gray(grass_gauss));
honey_gauss = uint8(255 * mat2gray(honey_gauss));
barbara_gauss = uint8(255 * mat2gray(barbara_gauss));

figure(9),imshow(barbara_gauss);
title('barbara Gaussian')

figure(10),imshow(honey_gauss);
title('honey Gaussian')

figure(11),imshow(grass_gauss);
title('grass Gaussian')

rmsd_grass;
rmsd_honey;
rmsd_barbara;
