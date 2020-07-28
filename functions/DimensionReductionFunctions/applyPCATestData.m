function [Y_test_score] = applyPCATestData(testData,W_PCA, PCA_dim)

[N,M] = size(testData(:,1:end-1));
Y_adjusted=zeros(N,M);
meanVec_test = mean(testData(:,1:end-1));

for j=1:M
    for i=1:N
        Y_adjusted(i,j) = testData(i,j) - meanVec_test(1,j); 
    end
end 

Y_test_score = Y_adjusted * W_PCA(:,1:PCA_dim);    % PCA Result

Y_test_score =[Y_test_score,testData(:,end)];

end


