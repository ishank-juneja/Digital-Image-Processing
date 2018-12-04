%Global handler script 

K= [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
k =100;
total_img = 32;
training = 6 ;
perimage = 10;
X = zeros(112*92,32*6); %size of one image

path = '../images/att_faces/s';
for  i = 1:total_img
    for j = 1:training
        img = im2double(imread(strcat(path,int2str(i),'/',int2str(j),'.pgm')));
        img =img(:);
       % mean_img = sum(img);
        %minus( img ,sum);
        %img - mean(img);

        X(:,(i-1)*6 + j) = img;
     end
end
%X = bsxfun(@minus , X, avg);
L =transpose(X)*X;
wrong = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
acc = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

for  i = 1:13
wrong(i) = myPCA(K(i),L,X,total_img,perimage,training,path)/128;
acc(i) = 1-wrong(i);
end
figure(1),plot(K,wrong);
xlabel('K') 
ylabel('Error Rate') 
figure(2),plot(K,acc);
xlabel('K') 
ylabel('Accuracy ') 
