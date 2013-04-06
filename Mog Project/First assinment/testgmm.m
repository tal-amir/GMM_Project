function [npatch,dpatch,npsnr,dpsnr] = testgmm(patch,GS,sigma,testname)
randn('seed',0);

outdir = ['./results/' testname];

patch = im2double(patch);
npatch = imnoise(patch,'gaussian',0,sigma^2);
[npsnr nmse] = calcpsnr(255*patch,255*npatch);
dpatch = patchmmse(vec2mat(npatch,1),GS,sigma);
dpatch = vec2mat(dpatch,8);
[dpsnr dmse] =calcpsnr(255*patch,255*dpatch);

collage = [patch zeros(8,1) npatch; zeros(1,17); patch zeros(8,1) dpatch];

collage = collage - min(collage(:));
collage = collage / max(collage(:));

mkdir(outdir);
imwrite(collage, [outdir '/collage.png']);

fileID = fopen([outdir '/report.txt'],'w');


fprintf(fileID, 'Test name: %s\n', testname); fprintf(fileID, '\n');
fprintf(fileID, 'Noisy PSNR: %f  MSE: %f\n', npsnr, nmse);
fprintf(fileID, 'Denoise PSNR: %f  MSE: %f\n', dpsnr, dmse);

fclose(fileID);

imshow(collage,[]); hold on;
title('First row: Original patch vs noisy second row: original vs denoised patch');