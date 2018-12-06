

A = '/Users/deveshkumar/Desktop/sem5/assignment1/2/data/church.png';
B = imread(A,'png');
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
 figure(3), imshow(c);

  figure(5), imshow(B);

