function [  output] = his_eq_clahe( hist_org,channel)
% For the myCLAHE function

e = cumsum(hist_org);
e = e*256/e(256,1);
e=uint8(e);
channel =e(channel+1);


output = channel - 1;


end

