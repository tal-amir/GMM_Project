function [psnr rmse] = calcpsnr(noisyimage,image)

% calculate mse
mse=mean2((noisyimage-image).^2);
% calc psnr
%psnr=10*log10((255^2)/(mse));
psnr=20*log10(1/std2(image-noisyimage));
rmse=sqrt(mse);

