function [ output ] = myAHE( B,w )
%Performs AHE on an image with a variable window size
[rows,columns] = size(B);

result = uint8( zeros(rows,columns));

org = B;

for x=  2:1:(rows)-1
    for y= 2:1:(columns)-1
     if x > (rows)- w
        if y >(columns)- w
            z =min(rows-x,columns-y);
            n_r = org(x-z:x+z,y-z:y+z);
            dummy = myHE(n_r);
            [g,t] = size(dummy);
            result(x,y) = dummy(uint8(g/2),uint8(t/2));
        end
        if y > w && y<(columns)-w
            n_r = org(x-rows+x:rows,y+x-rows:y-x+rows);
            dummy = myHE(n_r);
            %dummy=histeq(n_r,256);
            [g,t] = size(dummy);
            result(x,y) = dummy(uint8(g/2),uint8(t/2));
        end
        if y < w
             z =min(rows-x,y);
            n_r = org(x-z+1:x+z,y-z+1:y+z);
            dummy = myHE(n_r);
            %dummy=histeq(n_r,256);
            [g,t] = size(dummy);
            result(x,y) = dummy(uint8(g/2),uint8(t/2));
        end
    
    else
        if y>columns - w
            z =min(x,columns-y);
            n_r = org(x-z+1:x+z,y-z+1:y+z);
            dummy = myHE(n_r);
            [g,t] = size(dummy);
            result(x,y) = dummy(uint8(g/2),uint8(t/2));
        end
            
    end
   end
end


%figure(1), imshow(result)

for x=  1:1:(rows)-w
    for y= 1:1:(columns)-w
        if x>w
            if y>w
                n_r = org(x-w+1:x+w, y-w+1:y+w);
                dummy = myHE(n_r);
                %dummy=histeq(n_r,256);
                result(x,y) = dummy(w,w);
            else %y<w and x>w
                n_r = org(x-y+1:x+y, 1:y+y+1);
                dummy = myHE(n_r);
                %dummy=histeq(n_r,256);
                result(x,y) = dummy(y,y);       
             end
        else
             if y > w
                n_r = org(1:x+x+1, y-x+1:x+y);
                dummy = myHE(n_r);
                %dummy=histeq(n_r,256);
                result(x,y) = dummy(x,x);
             else
                 n_r = org(1:x+x, 1:y+y);
                dummy = myHE(n_r);
                %dummy=histeq(n_r,256);
                result(x,y) = dummy(x,y);

             end
        end
    end
end

output = result;

end

