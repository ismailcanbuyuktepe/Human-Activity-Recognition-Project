function [normalizedData,param1,param2] = normalizationFunc(dataSet,normMethodNum)
% This function can apply 2 type normalization method. You can set
% "normMethodNum" variable as 1 or 2. If you choose "normMethodNum == 1"
%function apply 0-1 normalization or you choose like "normMethodNum == 2"
%function apply softmax normalization. [-1 1]

% output Param: normalizedData : Normalized Data
%               param1 : You must use when normalized your test data
%               param2 : You must use when normlized your train data



[sample,feature] = size(dataSet);
normalizedData = zeros(sample,feature);
param1=zeros(1,feature-1);
param2=zeros(1,feature-1);
rRate=0.3;

if normMethodNum == 1
    for i=1:feature-1
        minValue = min(dataSet(:,i));
        maxValue = max(dataSet(:,i));  
        param1(1,i)=minValue;
        param2(1,i)=maxValue;
        for j=1:sample
            normalizedData(j,i)= (dataSet(j,i) - minValue) / (maxValue - minValue);
        end
    end
    normalizedData(:,end)=dataSet(:,end);

elseif normMethod == 2
    param1 = std(dataSet(:,1:end-1));
    param2 = mean(dataSet(:,1:end-1));
    for i=1:feature-1
        for j=1:sample
           normalizedData(j,i) =  (2/(1+exp(-1*(dataSet(j,i)-meanVector(1,i))/rRate*stdVector(1,i))))-1;
        end
    end
    normalizedData(:,end)=dataSet(:,end);
end

