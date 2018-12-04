%path = '/Users/deveshkumar/Desktop/barbara256.png';
path = '.../barbara256.png';

barbara_org =  im2double(imread(path));
padding = size(barbara_org,1)/2;
barbara = padarray(barbara_org,[padding,padding],'both');
fft_barbara =fftshift( fft2(barbara));
lpf_80a = fspecial('disk',80);
lpf_40a = fspecial('disk',40);

lpf_80  = padarray(lpf_80a,[176,176],'both');
lpf_40 = padarray(lpf_40a,[216,216],'both');

lpf_80 = lpf_80(1:512 , 1:512);
lpf_80 = lpf_80/max(max(lpf_80));

lpf_40 = lpf_40(1:512 , 1:512);
lpf_40 = lpf_40/max(max(lpf_40));


%lpf_40 = fft(lpf_40);
%lpf_80 = fft(lpf_80);
barbara_lpf_40 =real( ifft2(ifftshift(fft_barbara.*lpf_40)));
barbara_lpf_80 = real(ifft2(ifftshift(fft_barbara.*lpf_80)));


barbara_lpf_40 = barbara_lpf_40(128:384,128:384);
barbara_lpf_80 = barbara_lpf_80(128:384,128:384);

figure(3),imshow(barbara_lpf_40);
title('barbara Ideal lpf d = 40 ')
figure(4),imshow(barbara_lpf_80);
title('barbara Ideal lpf d = 80 ')



    gaussian_40 = fspecial('gaussian', 512, 40);
    gaussian_40 = gaussian_40 / max(max(gaussian_40));
    
    gaussian_80 = fspecial('gaussian', 512, 80);
    gaussian_80 = gaussian_80 / max(max(gaussian_80));

    barbara_gaussian_40 =real( ifft2(ifftshift(fft_barbara.*gaussian_40)));
    barbara_gaussian_80 = real(ifft2(ifftshift(fft_barbara.*gaussian_80)));
    
 barbara_gaussian_40 = barbara_gaussian_40(128:384,128:384);
 barbara_gaussian_80 = barbara_gaussian_80(128:384,128:384);

figure(5),imshow(barbara_gaussian_40);
title('barbara gaussian sigma = 40 ')
figure(6),imshow(barbara_gaussian_80);
title('barbara gaussian sigma = 80')

lpf_40 = log( lpf_40+1);
lpf_80 =log( lpf_80+1);
gaussian_40=log( gaussian_40+1);
gaussian_80=log( gaussian_80+1);

figure(7),imshow(lpf_40);
title('Ideal LPF d = 40 ')
figure(8),imshow(lpf_80);
title('Ideal LPF d = 80')


figure(9),imshow(gaussian_40);
title(' gaussian sigma = 40 ')
figure(10),imshow(gaussian_80);
title(' gaussian sigma = 80')



