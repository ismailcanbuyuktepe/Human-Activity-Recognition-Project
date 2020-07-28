function [Y] = applyLDATestData(normalizedTestData,W_LDA)

[sample,~] = size(normalizedTestData);
[~,feature] = size(W_LDA);

Y= zeros(sample,feature);

for i=1:sample
   Y(i,:) = normalizedTestData(i,1:end-1) * W_LDA; 
end

Y=[Y,normalizedTestData(:,end)];

end
