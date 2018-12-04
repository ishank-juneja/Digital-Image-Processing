function [outputArg1] = MYq2(k,vector,image)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
vector = vector(:,1:k);

alpha=transpose(vector)*image; 
new = vector*alpha;
new = reshape(new,192,168);
outputArg1 =new;




%vector = X*vector;


%alpha=transpose(vector)*image;
%new = vector * alpha;
%new = reshape(new,192,168);
%new1 =new*256/max((max(new))); 
%new1= uint8(new1);
end

