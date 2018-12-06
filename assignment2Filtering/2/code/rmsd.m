function [output] = rmsd(in1,in2)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
[rows,columns] = size(in1);


in1=    double(in1);
  in1 = in1 / max(in1(:));
in2 = in2 / max(in2(:));

diff = double(in1) - in2;
diff = diff.*diff;
%dummy = sqrt(sum(sum(diff.^2)) / numel(diff));
dummy = sum(diff(:));
output= sqrt(dummy/((rows*columns)));

end

