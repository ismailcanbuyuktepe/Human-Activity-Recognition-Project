function [w,eachClassCell] = keslersReconstruction(trainData,numbOfClass,learningRate,numbOfIteration)
%% Function Desription
%This function should use for creation kessler's reconstruction dataset.
% After you obtain kessler's reconstruction dataset and after you should use
%Gradient Descent Algorithm find w matrix.

% IMPORTANT NOTE
%If your train matrix change , you should run this function one time again.

%% Variables
[numbOfSample,numbOfFeature] = size(trainData);
numbOfFeature =numbOfFeature-1;  % to minus labels effect;
%% Adjust each Class element and store matrix
eachClassCell = cell(1,numbOfClass);
indexMatrix = [];
temp = [];

w=[3 2 1 1,-0.5 1 1 1, -3 -2 1 1, 1 1 1 1];

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
newFeatureVec = zeros(3,sizeOfReconstMatrix);
misClassifiedMatrix = [];

for m=1:numbOfIteration
     for k=1:numbOfSample
         x= trainData(k,1:end-1);
         x=[x,1];
         if (trainData(k,end) == 1)
              for j=1:numbOfClass
                  if(j==2)
                     newFeatureVec(1,:)=[x,-1*x,zeros(1,8)];
                  elseif(j==3)
                     newFeatureVec(2,:)=[x,zeros(1,4),-1*x,zeros(1,4)];
                  elseif(j==4)
                     newFeatureVec(3,:)=[x,zeros(1,8),-1*x];
                  end
              end 
              %MisClassified Detection
              [misClassified] = missClassifedDetection(w,newFeatureVec);
              misClassifiedMatrix =[misClassifiedMatrix,misClassified];

         elseif(trainData(k,end) == 2)
              for j=1:numbOfClass
                  if(j==1)
                     newFeatureVec(1,:)=[-1*x,x,zeros(1,8)];
                  elseif(j==3)
                     newFeatureVec(2,:)=[zeros(1,4),x,-1*x,zeros(1,4)];
                  elseif(j==4)
                     newFeatureVec(3,:)=[zeros(1,4),x,zeros(1,4),-1*x];
                  end
             end
             %MisClassified Detection
             [misClassified] = missClassifedDetection(w,newFeatureVec);
             misClassifiedMatrix =[misClassifiedMatrix,misClassified];

          elseif(trainData(k,end) == 3)
              for j=1:numbOfClass
                  if(j==1)
                     newFeatureVec(1,:)=[-1*x,zeros(1,4),x,zeros(1,4)];
                  elseif(j==2)
                     newFeatureVec(2,:)=[zeros(1,4),-1*x,x,zeros(1,4)];
                  elseif(j==4)   
                     newFeatureVec(3,:)=[zeros(1,8),x,-1*x];
                  end
              end
              %MisClassified Detection
             [misClassified] = missClassifedDetection(w,newFeatureVec);
             misClassifiedMatrix =[misClassifiedMatrix,misClassified];

          elseif(trainData(k,end) == 4)
              for j=1:numbOfClass
                   if(j==1)
                       newFeatureVec(1,:)=[-1*x,zeros(1,8),x];
                   elseif(j==2)
                       newFeatureVec(2,:)=[zeros(1,4),-1*x,zeros(1,4),x];
                   elseif(j==3)
                       newFeatureVec(3,:)=[zeros(1,8),-1*x,x];
                   end
              end
              %MisClassified Detection
              [misClassified] = missClassifedDetection(w,newFeatureVec);
              misClassifiedMatrix =[misClassifiedMatrix,misClassified];
         end
        %misClassifiedMatrix = -1*misClassifiedMatrix;
        if ~isempty(misClassifiedMatrix) 
            cost = sum(misClassifiedMatrix,2);
            [w_new] = calculateWeight(w,cost,learningRate);
            w=w_new;
            misClassifiedMatrix=[];
        end
     end
end
end

