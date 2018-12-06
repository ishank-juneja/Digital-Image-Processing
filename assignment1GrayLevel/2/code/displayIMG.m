function displayIMG(img, str)
%Adds axes and color bar to display image
figure, imshow(img);
title(str)
colorbar(gca);
axis on;
end