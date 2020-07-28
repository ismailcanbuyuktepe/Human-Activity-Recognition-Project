function [classifierLabels] = applyPerceptron(testData,w)

% Description: This function do classification your test data using w 
%              (weight) vector.
% Output Param: classifierLabels : Return classifier labels

[numbOfSample,~] = size(testData);

w1 = w(1:4);
w2 = w(5:8);
w3 = w(9:12);
w4 = w(13:16);

extendedTestData = [testData(:,1:end-1),ones(numbOfSample,1)];

for i= 1:numbOfSample
    g1(i,:) = w1*extendedTestData(i,:).';
    g2(i,:) = w2*extendedTestData(i,:).';
    g3(i,:) = w3*extendedTestData(i,:).';
    g4(i,:) = w4*extendedTestData(i,:).';
    
    
    if(g1(i,:)>g2(i,:)) && (g1(i,:)>g3(i,:)) && (g1(i,:)>g4(i,:))
        classifierLabels(i) = 1;
    elseif (g2(i,:)>g1(i,:)) && (g2(i,:)>g3(i,:)) && (g2(i,:)>g4(i,:))
        classifierLabels(i) = 2;
    elseif (g3(i,:)>g1(i,:)) && (g3(i,:)>g2(i,:)) && (g3(i,:)>g4(i,:))
        classifierLabels(i) = 3;
    elseif (g4(i,:)>g1(i,:)) && (g4(i,:)>g2(i,:)) && (g4(i,:)>g3(i,:))
        classifierLabels(i) = 4;
    end    
end


end

