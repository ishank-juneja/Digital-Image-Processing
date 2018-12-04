I1 = '/Users/deveshkumar/Desktop/sem5/assignment1/2/data/barbara.png';
I2 = '/Users/deveshkumar/Desktop/sem5/assignment1/2/data/TEM.png';
I3 = '/Users/deveshkumar/Desktop/sem5/assignment1/2/data/canyon.png';
I4 = '/Users/deveshkumar/Desktop/sem5/assignment1/2/data/retina.png';
I5 = '/Users/deveshkumar/Desktop/sem5/assignment1/2/data/church.png';
barbara = imread(I1,'png');
TEM = imread(I2,'png');
canyon = imread(I3,'png');
retina = imread(I4,'png');
church = imread(I5,'png');

%histogram equilization
bar_hiseq = his_eq(barbara);
TEM_hiseq = his_eq(TEM);
canyon_hiseq = hist_eq_col(canyon);
retina_hiseq = hist_eq_col(retina);
church_hiseq = hist_eq_col(church);

figure(11), imshow(bar_hiseq)
title('Barbara Histogram Equalization')
figure(12), imshow(TEM_hiseq)
title('TEM Histogram Equalization')
figure(13), imshow(canyon_hiseq)
title('canyon Histogram Equalization')
figure(14), imshow(retina_hiseq)
title('retina Histogram Equalization')
figure(15), imshow(church_hiseq)
title('church Histogram Equalization')
%%
%histogram matching
I6='/Users/deveshkumar/Desktop/sem5/assignment1/2/data/retinaRef.png';
I7='/Users/deveshkumar/Desktop/sem5/assignment1/2/data/retinaMask.png';
I8= '/Users/deveshkumar/Desktop/sem5/assignment1/2/data/retinaRefmask.png';
ret_ref =imread(I6,'png');
ret_m=imread(I7,'png');
ret_ref_m=imread(I8,'png');
retina_hist_mat = hist_match(retina,ret_ref,ret_m,ret_ref_m);
figure(16),imshow(retina_hist_mat);
title(' Histogram Matched')
figure(17),imshow(retina);
title(' Original Image Histogram Matching')
figure(18),imshow(retina_hist_mat);
title('  Referenced Image Histogram Matching')
%%
%Adaptive histogram Equilization
%w = 25% window size = 2*w+1
%barbara_AHE= myAhe(barbara,50);
%figure(19),imshow(barbara_AHE);
%title('barbara AHE');
%TEM_Ahe= myAhe(TEM,30);
%figure(20),imshow(TEM_Ahe);
%title('TEM AHE');

redChannel = canyon(:, :, 1);
greenChannel = canyon(:, :, 2);
blueChannel = canyon(:, :, 3);
%red_ahe = myAhe(redChannel,20);
%green_ahe = myAhe(greenChannel,20);
%blue_ahe = myAhe(blueChannel,20);


%canyan_Ahe(:, :, 1) = red_ahe;
%canyan_Ahe(:, :, 2) = green_ahe;
%canyan_Ahe(:, :, 3) = blue_ahe;

%figure(21),imshow(canyan_Ahe);
%title('canyan AHE');
%%
%clahe
TEM_CLAHE= myCLAHE(TEM,10,100);
figure(23),imshow(TEM_CLAHE);
title('TEM CLAHE');

barbara_CLAHE= myCLAHE(barbara,10,260);
figure(22),imshow(barbara_CLAHE);
title('barbara CLAHE');

red_clahe = myCLAHE(redChannel,20,10000);
green_clahe = myCLAHE(greenChannel,20,10000);
blue_clahe = myCLAHE(blueChannel,20,10000);

canyan_clAhe(:, :, 1) = red_clahe;
canyan_clAhe(:, :, 2) = green_clahe;
canyan_clAhe(:, :, 3) = blue_clahe;
figure(24),imshow(canyan_clAhe);
title('Canyan CLAHE');

