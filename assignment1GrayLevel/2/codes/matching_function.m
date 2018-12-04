function [ output ] = matching_function( input, refer,mask_ori,mask_ref)%
org = input.*mask_ori;
ref = refer.*mask_ref;

%figure(1), imhist(org);
%red = c(:,:,1);
%figure(100),imshow(red);
%figure(2), imshow(org);

org_hist = imhist(org,256);
%org_hist(1) =[];
org_cdf = cumsum(org_hist);
org_cdf = org_cdf*254/org_cdf(255,1);
org_cdf = uint8(org_cdf);
org_cdf(1)=1;
ref_hist= imhist(ref,256);
%ref_hist(1) = [];
ref_cdf = cumsum(ref_hist);
ref_cdf = ref_cdf*254/ref_cdf(255,1);
ref_cdf = uint8(ref_cdf);
dummy =  uint8( zeros(size(ref_cdf)));

for x= 1:1:255
dummy(ref_cdf(x,1)+1,1)=x;
end
for x= 255:-1:1
    if dummy(x)== 0
        dummy(x)=dummy(x+1);
    end
end
dummy(255)= dummy(254)+1;
org = org_cdf(org + 1);
org = dummy(org);
output = org -1;

end

