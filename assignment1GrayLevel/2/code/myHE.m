function [output] = myHE (channel)
%Performs Global Histogram Eq on a image

channel=channel+1;
redChannel = channel;

d = imhist(redChannel,256);
e = cumsum(d);
e = e*256/e(256,1);
e=uint8(e);
redChannel =e(redChannel);

output = redChannel - 1;
end


