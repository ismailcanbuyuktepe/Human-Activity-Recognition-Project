function [accuracy] = perceptronAccuracy(classifierLabels,testData)

[numbOfSample,~] = size(testData);

correctLabelCount = 0;

for i=1: numbOfSample
    if(classifierLabels(i) == testData(i,end))
        correctLabelCount =correctLabelCount+1;
    end   
end

accuracy = (correctLabelCount/numbOfSample)*100;

end
