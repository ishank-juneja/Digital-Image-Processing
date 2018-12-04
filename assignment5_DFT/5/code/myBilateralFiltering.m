function [output,dist_gauss] =  myBilateralFiltering(input,w,I_sig,D_sig)
%Function to perform Bilateral Filtering
%Author Devesh Kumar 

[rows,columns] = size(input);
dist_gauss = zeros(w, w);
for x= 1:1:2*w
    for y=1:1:2*w
        dist_gauss(x,y) = (exp(-((x-w)*(x-w)+(y-w)*(y-w)))/(2*D_sig*D_sig));
    end
end
dist_gauss = (dist_gauss/sum(dist_gauss(:)));
for x= w:rows
    for y=w:columns
         low = max(x-w,1);
         up = min(x+w,rows);
         left = max(y-w,1);
         right = min(y+w,columns);
        window =  input(low:up-1,left:right-1);
        %window =  input(x-w+1:x+w,y-w+1:y+w);

         i_gauss = window - input(x,y);
         i_gauss = exp(-(i_gauss).^2/(2*I_sig^2));
      %   i_gauss = (i_gauss/sum(i_gauss(:)));
         
         [rows2,columns2] = size(i_gauss);
        dummy = i_gauss.*dist_gauss((1:rows2),(1:columns2));
         dummy2 = (window.*dummy)/sum(dummy(:));
         output(x,y)= sum(dummy2(:));
    end
end
% for the edge cases covering the cornors
for x= 1:rows
    for y=1:columns
        if x<w|| y<w
        low = max(x-w,1);
         up = min(x+w,rows);
         left = max(y-w,1);
         right = min(y+w,columns);
         alpha = (up - low)/2;
         beta = (right - left)/2;
        window2 =  input(low:up-1,left:right-1);
        i= 1;
        for k = low:up
            j=1;
            for l = left:right
                 dist_gauss2(i,j) = (exp(-((i - alpha)*(i - alpha)+(j-beta)*(j-beta)))/(2*D_sig*D_sig));
             
                j=j+1;
            end
            i=i+1;
        end
        i_gauss2 = window2 - input(x,y);
        i_gauss2 = exp(-(i_gauss2).^2/(2*I_sig^2));
        [rows2,columns2] = size(i_gauss2);
        dummy3 = i_gauss2.*dist_gauss((1:rows2),(1:columns2));
         dummy4 = (window2.*dummy3)/sum(dummy3(:));
         output(x,y)= sum(dummy4(:));
        end
    end
end