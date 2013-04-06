function y = mogrnd(GS)
means=GS.means;
weights=GS.mixweights/sum(GS.mixweights);
covs=GS.covs;

size(weights)
%choose index of Gaussian according to weights
idx=find(mnrnd(1,weights));
% generate a smaple from the chosen Gaussian
idx
size(means(:,idx))
size(covs(:,:,idx))
sample=mvnrnd(means(:,idx),covs(:,:,idx));
%convert sample to matrix [patch of 8X8]
y=vec2mat(sample,8);
y=y-min(y(:));
y=y/max(y(:));
imwrite(y,'multiple_Gaussians_sample.jpeg');