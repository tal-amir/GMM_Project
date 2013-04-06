function out = im2patch(patches, m ,n)

out = zeros(m,n);
weights = zeros(m,n);

patchIdx = 0;


for i=1:m-7
    for j=1:n-7
        patchIdx = patchIdx + 1;
        temp = vec2mat(patches(:, patchIdx),8);
        
        out(i:i+7, j:j+7) = out(i:i+7, j:j+7) + temp;
        weights(i:i+7, j:j+7) = weights(i:i+7, j:j+7) + 1;   
    end
end

out = out ./ weights;
