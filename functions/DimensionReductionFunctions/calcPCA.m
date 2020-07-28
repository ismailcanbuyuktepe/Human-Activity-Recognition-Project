function [Y_score,W,lambda,R_optimal] = calcPCA(X,R)

% input Param : X : nxm X
%               R : first R principle Component of X

% Output Param: Y_score : PCA result matrix nxR
%                   W : eigenVector matrix of covariance matrix mxm
%                lambda : eigenValue matrix of covariance matrix mxm
%                R_optimal : Optimum Value of first R principle Component
%                of X for eigenvalue of %90;

[N,M] = size(X(:,1:end-1));

if (R < 1)
  error('PCA: must return at least 1 principal component.')
end

if (R > M)
  error('PCA: can''t get more principal components than dimensions.')
end

sumValue =0;
meanVec =zeros(1,M);
covariance = zeros(M,M);

% Mean Vector Calculated
for i= 1:M
    for j=1:N
       sumValue = sumValue+X(j,i); 
    end
       sumValue = sumValue/N;
       meanVec(1,i) = sumValue;
       sumValue =0;
end

% Calculate Covarince Matrix
for i=1:N
   sumValue = sumValue + ((X(i,1:end-1)- meanVec(1,:)).' * (X(i,1:end-1)- meanVec(1,:))); 
end
covariance = (1/(N-1)) *sumValue;
sumValue =0;

% Calculate covariance matrix eigen value eigenVec
% lambda: eigen value diagonel matrix
% W : eigenvector matrix

[W,lambda] = eig(covariance);

% Re-order W and lambda matrix for construct PCA matrix

W = W(:,end:-1:1);
lambda = lambda(:,end:-1:1);

% The best PCA score calculation.
lambdaVec = sum(lambda);
lambdaSumValue = sum(lambdaVec);
desiredValue = 0.9*lambdaSumValue;
counter =0;
R_optimal=0;
for i=1:M
    counter = counter+lambdaVec(1,i);
    if(counter>=desiredValue)
        R_optimal = i;
        break;
    end
end

%PCA result
X_adjusted=zeros(N,M);
for j=1:M
    for i=1:N
        X_adjusted(i,j) = X(i,j) - meanVec(1,j); 
    end
end 

Y_score = X_adjusted * W(:,1:R);    % PCA Result
Y_score =[Y_score,X(:,end)];

end

