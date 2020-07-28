function [accuracy,classifierResultVec] = kNNRule(trainData,testData,k_point,distanceValue,numOfClass)

% This function calculate k-NN rule classifier algorithm. And this function
% return accuray and label of test data at the end of this algorithm.

% Input Param: trainData : Train dataset.
%              testData : Test dataset.
%              k_point : number of k point.
%              distanceValue : if you use euclidian distance this value is
%              equal 1. If you use manhattan distance this value is equal 2
%              numOfClass = number Of Class.

[trainSample,feature] = size(trainData);
[testSample,~] = size(testData);

tempMinDisVec = zeros(1,trainSample);
indexVector = zeros(testSample , k_point);
classCounterVec = zeros(1,numOfClass);
classifierResultVec=zeros(testSample,1);

if(distanceValue == 1)
   %Euclidian Distance
   for i=1:testSample
       for j=1:trainSample
           tempDistanceVec(1,j) = norm(testData(i,1:end-1) - trainData(j,1:end-1));
       end
       
       for k=1:k_point
           [~ ,indexVec(i,k)] = min(tempDistanceVec(1,:));
           tempDistanceVec(1,indexVec(i,k)) =100000000;   
       end
   end
    
elseif(distanceValue == 2)
    %Manhattan Distance
    for i=1:testSample
       for j=1:trainSample
           tempDistanceVec(1,j) = sum(abs(testData(i,1:end-1) - trainData(j,1:end-1)));
       end
       
       for k=1:k_point
           [~ ,indexVec(i,k)] = min(tempDistanceVec(1,:));
           tempDistanceVec(1,indexVec(i,k)) =100000000;
           
       end
   end
    
end

for i=1:testSample
   for j=1:k_point
        in = indexVec(i,j);
        classNo = trainData(in,end);
        classCounterVec(1,classNo)=classCounterVec(1,classNo)+1;
   end
   [~,index] = max(classCounterVec);
   classifierResultVec(i,1)=index;
   classCounterVec = zeros(1,numOfClass); 
end

% Total Accuracy
correctValue =0;
for i=1:testSample
   if(testData(i,end) == classifierResultVec(i,1))
       correctValue =correctValue+1;
   end
end

accuracy = (correctValue/testSample)*100;
fprintf("k-NN Rule total accuracy is : %3.3f",accuracy);


end

