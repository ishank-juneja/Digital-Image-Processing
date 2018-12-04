function [hist_org  ] = clahe_fun( B,n )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


[rows,columns] = size(B);
hist_org = imhist(B,256);

for x=  1:1:256
    if hist_org(x) > n
        hist_p(x) = hist_org(x)- n;
        hist_org(x) =  n;
    else
        hist_p(x) = 0;
    end
end
 integrate = cumsum(hist_p);
  l = integrate(256)/ n ;
  hist_org = hist_org + double(l);
 % hist_org = int16( hist_org);
  

end

