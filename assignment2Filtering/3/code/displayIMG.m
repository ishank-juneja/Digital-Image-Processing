function displayIMG(img, description)
%Adds axes and color bar to display image
figure, imshow(img);
title(description)
colorbar(gca);
axis on;
end