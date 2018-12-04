%% MyMainScript

tic;
%% Your code here
im = imread('Moon_Original.jpg')
img = rgb2gray(im);
h = [0 -1 0; -1 4 -1; 0 -1 0];
y = [0 0 0; 0 1 0; 0 0 0];
g = y + 3*h;
out = imfilter(img,g);
figure(1);
imshow(img);
figure(2);
imshow(out);
toc;
