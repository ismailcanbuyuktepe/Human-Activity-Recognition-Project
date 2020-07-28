function [reconstFeatureVec] = keslersReconstruction(trainData,numbOfClass)
%% Function Desription
%This function should use for creation kessler's reconstruction dataset.
%This function just use for one time and function save reconstruction
%matrix. I run one time and I created a reconstruction matrix called 
%'reconstMatrix.mat'.

% IMPORTANT NOTE
%If your train matrix change , you should run this function one time again.

%% Variables
[numbOfSample,numbOfFeature] = size(trainData);
numbOfFeature =numbOfFeature-1;  % to minus labels effect;
%% Adjust each Class element and store matrix
eachClassCell = cell(1,numbOfClass);
indexMatrix = [];
temp = [];
for i=1:numbOfClass
    indexMatrix = find(trainData(:,end) == i);
    for j=1:size(indexMatrix,1)
        temp = [temp;trainData(indexMatrix(j,1),:)];
    end  
    eachClassCell{1,i} = temp;
    temp=[];
end
%% Construct each x vector
sizeOfReconstMatrix = (numbOfFeature+1)*numbOfClass;
reconstFeatureVec = [];
newFeatureVec = zeros(1,sizeOfReconstMatrix);

 for k=1:numbOfSample
     x = trainData(k,1:end-1);
     x=[x,1];
    for i=1:numbOfClass
       for j=1:numbOfClass
           if(i~=j)
              if(i==1)
                  if(j==2)
                      newFeatureVec=[x,-1*x,zeros(1,8)];
                  elseif (j==3)
                      newFeatureVec=[x,zeros(1,4),-1*x,zeros(1,4)];
                  elseif (j==4)
                      newFeatureVec=[x,zeros(1,8),-1*x];
                  end
              elseif (i ==2)
                  if(j==1)
                      newFeatureVec=[-1*x,x,zeros(1,8)];
                  elseif (j==3)
                      newFeatureVec=[zeros(1,4),x,-1*x,zeros(1,4)];
                  elseif (j==4)
                     newFeatureVec=[zeros(1,4),x,zeros(1,4),-1*x];
                  end
              elseif i==3
                  if(j==1)
                      newFeatureVec=[-1*x,zeros(1,4),x,zeros(1,4)];
                  elseif (j==2)
                      newFeatureVec=[zeros(1,4),-1*x,x,zeros(1,4)];
                  elseif (j==4)
                      newFeatureVec=[zeros(1,8),x,-1*x];
                  end
              elseif i==4
                  if(j==1)
                      newFeatureVec=[-1*x,zeros(1,8),x];
                  elseif (j==2)
                      newFeatureVec=[zeros(1,4),-1*x,zeros(1,4),x];
                  elseif (j==3)
                      newFeatureVec=[zeros(1,8),-1*x,x];
                  end    
              end
              reconstFeatureVec = [reconstFeatureVec;newFeatureVec];
           end  
       end
    end
    
 end



end

