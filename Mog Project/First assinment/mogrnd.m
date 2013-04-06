function y = mogrnd(covs,means,weights)

%choose index of Gaussian according to weights
idx=find(mnrnd(1,weights));
% generate a smaple from the chosen Gaussian
sample=mvnrnd(means(:,idx),covs(:,:,idx));
%convert sample to matrix [patch of 8X8]
y=vec2mat(sample,8);