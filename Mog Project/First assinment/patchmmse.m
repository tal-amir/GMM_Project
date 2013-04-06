function xmmse = patchmmse(y,GS,sigma)

dc = mean(y(:));
y = y - dc;

xmmse=zeros(64,1);

n = zeros(200,1);

for i=1:numel(GS.mixweights)
    n(i)=mvnpdf(y,GS.means(:,i),GS.covs(:,:,i)+sigma^2*eye(64));
end
    
fy=GS.mixweights'*n;

testweights = zeros(200,1);

for j=1:length(GS.mixweights)
        %w=GS.means(j)+(1/sigma^2)*(((1/sigma^2)*eye(64)+inv(GS.covs(:,:,j)))\(y-GS.means(:,j)));
        %w=GS.means(j)+((eye(64)+sigma^2*inv(GS.covs(:,:,j)))\(y-GS.means(:,j)));
        %w=GS.means(j)+((eye(64)+sigma^2*(eye(64)/GS.covs(:,:,j))) \ (y-GS.means(:,j)));
        w=GS.means(j)+GS.covs(:,:,j)*((GS.covs(:,:,j)+sigma^2*eye(64)) \ (y-GS.means(:,j)));
        xmmse = xmmse + w*n(j)*GS.mixweights(j);
        testweights(j) = n(j)*GS.mixweights(j);
end
xmmse = xmmse/fy + dc;

testweights = testweights / fy;
%fprintf('Min of weights: %f, sum of weights: %f\n', min(testweights), sum(testweights));