function [wrong_out] = myPCA(k,L,X,total_img,perimage,training,path)


[vector,values] = eigs(L,k);%gives k largest eigen vector
V = X*vector;
V= normalize(V);
alpha = transpose(V) * X;

% test:
wrong = 0;
for  i = 1:total_img
    for j = training+1:perimage
        img = im2double(imread(strcat(path,int2str(i),'/',int2str(j),'.pgm')));
        img =img(:);
        %img = bsxfun(@minus , img, mean);
       % mean_img = sum(img);
        %minus( img ,sum);
        %img - mean(img);
        alpha_img = transpose(V)*img;
        error = alpha - alpha_img;
        error1 = error.^2;
        
        error2 = (sum(error1, 1)).^(0.5);
        [value, index] = min ( error2);
        output = floor((index-1)/6) + 1;
        if output ~= i 
            wrong = wrong + 1;
        end
    end
end

wrong_out = wrong;

end

