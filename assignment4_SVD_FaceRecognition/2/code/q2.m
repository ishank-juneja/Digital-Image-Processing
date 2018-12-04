path = '.../CroppedYale/YaleB0';
input_img = im2double(imread('.../CroppedYale/yaleB28/yaleB28_P00A+010E+00.pgm'));

D = strcat(path,int2str(1));
S = dir(fullfile(D,'*.pgm')); 
im4 = imread(strcat(S(1).folder,'/',S(1).name));
total_img = 39;
training = 40 ;
perimage = 64;
X = zeros(192*168,38*40); %size of one image
path = '.../CroppedYale/YaleB0';

k = [2,10,20,50,75,100,125,150,175];

for  i = 1:9
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
        for j = 1:training
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
       % mean_img = sum(img);
        %minus( img ,sum);
%        img - mean(img);

        X(:,(i-1)*40 + j) = img;
        end
    
end

path = '.../CroppedYale/YaleB';


for  i = 10:39
    if i ~= 14 %14th element not present
    D = strcat(path,int2str(i));
    S = dir(fullfile(D,'*.pgm')); 
        for j = 1:training
        img = im2double(imread(strcat(S(i).folder,'/',S(j).name)));
        img =img(:);
        X(:,(i-1)*40 + j) = img;
        end
    end
end

%X = X(:, 2:end);
%Average = mean(X, 2);
%X = X-Average;
%L =transpose(X)*X;
[vector,values,none] = svd(X, 'econ'); 
image = input_img(:);
[~,Bsort]=sort(diag(values),'descend'); %Get the order of B
vector=vector(:,Bsort);
%[none, sorting] = sort(diag(values),'descend');
%vector = vector(:, sorting);
square = sum(vector.^2,1);
vector = bsxfun(@rdivide, vector, square);



new =zeros(192,168,9);
for i= 1:9
new1 =  MYq2(k(i),vector,image);
new( :,:,i) = new1(:,:);
figure(i+25),imshow(new( :,:,i));
title(['K is ',num2str(k(i)),])
%title(k(i));
end
figure(100),imshow(input_img);
title('Input Image');
vector = vector(:,1:25);
eigen =uint8(zeros(192,168,25));

for i= 1:25
 vector(:,i) = abs((vector(:,i)));
 vector(:,i)=vector(:,i)*256/max(vector(:,i));
r = uint8( vector(:,i));
eigen( :,:,i) = reshape(r,192,168);

% i coulds not display all the eigen value in one page but it will show them
% simultaniously eigenface no1 beging the eigen face with largest value
%eigen( :,:,i) = eigen( :,:,i)*256/max(max(eigen( :,:,i)));
figure(i),imshow(eigen( :,:,i));
title(['EigenFace no',num2str(i),])
end
subplot(192,168,25)

%vector = vector(:,1:k(8));

%alpha=transpose(vector)*image; 
%new = vector*alpha;
%new = reshape(new,192,168);


%figure(2),imshow(new);


%vector = X*vector;


%alpha=transpose(vector)*image;
%new = vector * alpha;
%new = reshape(new,192,168);
%new1 =new*256/max((max(new))); 
%new1= uint8(new1);

