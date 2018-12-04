
A = zeros(300,300);
A(50:100,50:120) = 255;
tx = -30;
ty =70;
%figure(5),imshow(A);
%title('barbara gaussian sigma = 40 ');
A_T = imtranslate(A,[tx, ty],'FillValues',0);
%figure(6),imshow(A_T);

fft_A = ( fft2(A));
fft_A_T = ( fft2(A_T));
con_fft_A_T = conj(fft_A_T);

phase = fft_A .* con_fft_A_T;
phase = phase/(det(fft_A .* fft_A_T)+1);
fig = log( abs(phase+1));
fig = fig/max(max(fig));
figure(8),imshow((fig));
title('Magnitude of the cross-power spectrum ')

%phase = angle(phase);
phase_real =(( ifft2((phase))));
[M,I] = max(phase_real(:));
[I_row, I_col] = ind2sub(size(phase_real),I);

%%%%%%%%%%%%%%%%%%%%%%%%% after adding Gaussian noise %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AGauss  =  imnoise(A,'gaussian',0,4.6);
%AGauss_T = imnoise(A_T,'gaussian',0,4.6);
AGauss_T = imtranslate(AGauss,[tx, ty]);
figure(10),imshow((AGauss));
figure(11),imshow((AGauss_T));

fft_AGauss = ( fft2(AGauss));
fft_AGauss_T = ( fft2(AGauss_T));
con_fft_AGauss_T = conj(fft_AGauss_T);
phaseGauss = fft_AGauss .* con_fft_AGauss_T;
%%phaseGauss = phaseGauss/(det(fft_AGauss .* fft_AGauss_T)+1);
figGauss = log(abs(phaseGauss+1));
figGauss = figGauss/max(max(figGauss));
figGauss = figGauss*255;
%figGauss = figGauss/max(max(figGauss));
figure(9),imshow((uint8(abs(figGauss))));
title('Magnitude of the cross-power spectrum with Gaussian ');

phase_Gauss =(( ifft2((phaseGauss))));
[MGauss,IGauss] = max(phase_Gauss(:));
[IGauss_row, IGauss_col] = ind2sub(size(phase_Gauss),IGauss);




%figure(8),imshow(phase);
%figure(7),imshow(phase_real);
