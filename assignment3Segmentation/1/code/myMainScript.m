
%Load Images Using Relative Paths
I1 = load('../data/boat.mat');
%I1 = load('../data/boat.mat');
boat = I1.imageOrig;
boat_org = uint8(boat);
figure(3),imshow(boat_org);
var_smooth = 0.005;
var_corner = 5;
k = 0.223;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[IX_print,IY_print,eigen1,eigen2,rgbImage,corner] = myHarrisCornerDetector(var_smooth,var_corner,k,boat);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
corner = uint8(corner);

figure(3),imshow(IX_print);
title('x derivative');

figure(4),imshow(IY_print);
title('Y derivative');

figure(5),imshow(eigen1);
title('eigen Value');

figure(6),imshow(eigen2);
title('  eigen Value');


figure(9),imshow(rgbImage);
title(' final ans');

figure(7),imshow(corner);
title(' harris corner detection');

%i2 =  conv2(dx,boat,'same');