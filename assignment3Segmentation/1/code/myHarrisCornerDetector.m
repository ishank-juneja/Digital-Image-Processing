function [IX_print,IY_print,eigen1,eigen2,rgbImage,corner] = myHarrisCornerDetector(var_smooth,var_corner,k,boat)


%boat = boat/(max(boat(:)));
%figure(3),imshow(boat);
boat_org = uint8(boat);

boat = imgaussfilt(boat,var_smooth,'FilterSize', 5);
%%%%definening the differential operator(to find out the grad)
dx = [-1 -1 -1;0 0 0  ; 1 1 1];
dy = [-1 0 1;-1 0 1  ; -1 0 1];

GradX = conv2(dx,boat);
GradY = conv2(dy,boat);
GradX = GradX(2:513,2:513);
GradY = GradY(2:513,2:513);


IX_print = uint8(GradX);
IY_print = uint8(GradY);

I11 = GradX.*GradX;
I22 = GradY.*GradY;
I12 = GradY.*GradX;

IG11 = imgaussfilt(I11,var_corner,'FilterSize', 5);
IG22 = imgaussfilt(I22,var_corner,'FilterSize', 5);
IG12 = imgaussfilt(I12,var_corner,'FilterSize', 5);

TRACE = IG11+IG22;
det = IG11.*IG22 - I12.*I12; 
%%%%%%eigen value calculation
eigen1=(TRACE/2)-(abs((TRACE/2).^2 - det)).^(1/2);
eigen2=(TRACE/2)-(abs((TRACE/2).^2 +det)).^(1/2);


Corner_ness =  det -  k*(TRACE.*TRACE);
Corner_ness = Corner_ness/max(Corner_ness(:));
[rows,columns] = size(Corner_ness);
corner = zeros (rows,columns);
rgbImage = cat(3, boat_org, boat_org, boat_org);
%%%%%%thresholding 
for x = 1:rows
            for y = 1:columns
                if Corner_ness(x,y)< 0.0045
                Corner_ness(x,y) = 0;
                corner(x,y) = 0;
                else
                   cornes(x,y) = corner(x,y);
                 %  rgbImage(x,y,2) = 255;
                end
            end
end
%%%%%%%%%%non maximum 
for i=2:2:rows-2
    for j=2:2:columns-2
        
            v = (Corner_ness(i-1:i+1,j-1:j+1));
          maximum = max (max(v));
            [q,w]=find(v==maximum);
            v = zeros(3,3);
            v(q,w)= maximum;
           %(Corner_ness(i-1:i+1,j-1:j+1))= v ;
           for l=-1:1
                for k=-1:1
                    
                    Corner_ness(i+l,j +k) =v(l+2,k+2);
                end
           end
            
    end
end

%%%%%%%marking the values in original image
for x = 1:rows
            for y = 1:columns
                if Corner_ness(x,y)< 0.0045
                Corner_ness(x,y) = 0;
                corner(x,y) = 0;
                else
                   corner(x,y) = 255;
                   rgbImage(x,y,2) = 255;
                end
            end
end
corner = uint8(corner);

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

end

