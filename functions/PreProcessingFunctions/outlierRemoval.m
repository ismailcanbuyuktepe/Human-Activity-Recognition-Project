function [feaVec1] = outlierRemoval(feaVec1)

% Outlier detection and removal function. From feature vector

[dim] =size(feaVec1,2);
tf = isoutlier(feaVec1(:,1),'mean');
for j=2:dim
     outlierRows = find(tf);
     outlierLength = size(outlierRows,1);
     for i=1:outlierLength
         if size(feaVec1,1) < outlierRows(i)
             break
         end
         feaVec1(outlierRows(i),:)=[];
     end
tf = isoutlier(feaVec1(:,j),'mean');
end
   

end

