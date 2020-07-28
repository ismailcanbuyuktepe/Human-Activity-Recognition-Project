function [normalizedData] = normalizationForTestData(dataSet,param1 ,param2,normMethodNum)

% This function can apply 2 type normalization method. You can set
% "normMethodNum" variable as 1 or 2. If you choose "normMethodNum == 1"
%function apply 0-1 normalization or you choose like "normMethodNum == 2"
%function apply softmax normalization. [-1 1].

% This function should use for test data normalization. Because param1 and
% param2 are obtained train dataset using this function 'normalizationFunc'

% output Param: normalizedTestData : Normalized Data

[sample,feature] = size(dataSet);
normalizedData = zeros(sample,feature);
rRate=0.3;

if normMethodNum == 1
    for i=1:feature-1
        for j=1:sample
            normalizedData(j,i)= (dataSet(j,i) - param1(1,i)) / (param2(1,i) - param1(1,i));
        end
    end
    normalizedData(:,end)=dataSet(:,end);

elseif normMethod == 2
    param1 = std(dataSet(:,1:end-1));
    param2 = mean(dataSet(:,1:end-1));
    for i=1:feature-1
        for j=1:sample
           normalizedData(j,i) =  (2/(1+exp(-1*(dataSet(j,i)-param2(1,i))/rRate*param1(1,i))))-1;
        end
    end
    normalizedData(:,end)=dataSet(:,end);
end

end

