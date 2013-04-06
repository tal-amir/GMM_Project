function retval = GenerateFromSingleGaussian(GS)
weights = GS.mixweights;
covs=GS.covs;
A=zeros(64);

for i=1:numel(weights)
    A= A+weights(i)*covs(:,:,i);
end
retval = vec2mat(mvnrnd(zeros(64,1),A),8);
retval=retval-min(retval(:));
retval = retval/max(retval(:));

imwrite(retval,'one_Gaussian_sample.jpeg');
    