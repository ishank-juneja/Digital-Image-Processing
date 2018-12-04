function [ result ] = myHM( c,d,mask_ori,mask_ref )
%Performs Hitogram Matching

mask_ref = uint8(mask_ref);
mask_ori = uint8(mask_ori);

redChannel_o = c(:, :, 1);
greenChannel_o = c(:, :, 2);
blueChannel_o = c(:, :, 3);

redChannel_r = d(:, :, 1);
greenChannel_r = d(:, :, 2);
blueChannel_r = d(:, :, 3);

redChannel = matching_function(redChannel_o,redChannel_r,mask_ori,mask_ref);
greenChannel = matching_function(greenChannel_o,greenChannel_r,mask_ori,mask_ref);
blueChannel = matching_function(blueChannel_o,blueChannel_r,mask_ori,mask_ref);
redChannel(mask_ref ==0) =0;
greenChannel(mask_ref ==0) =0;
blueChannel(mask_ref ==0) =0;
result(:, :, 1) = redChannel;
result(:, :, 2) = greenChannel;
result(:, :, 3) = blueChannel;
end

