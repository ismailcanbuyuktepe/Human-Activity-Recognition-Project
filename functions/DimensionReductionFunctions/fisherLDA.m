function [Y_LDA,W_adjusted, lambda] = fisherLDA(trainDataSet , numberOfClass)

[sample,feature] = size(trainDataSet(:,1:end-1));
numberOfElementOfEachClass = zeros(1,numberOfClass);
elementOfEachClass = cell(1,numberOfClass);
counter=0;
classVector = [];
Sw=zeros(feature,feature);
Si=zeros(feature,feature);
Sb =zeros(feature,feature);

%% Find every class element and number of element
for i=1:numberOfClass
    for j=1:sample
        if(i==trainDataSet(j,end))
            counter=counter+1;
            classVector = [classVector;trainDataSet(j,:)];
        end
    end
    elementOfEachClass(1,i) = {classVector(:,:)};
    numberOfElementOfEachClass(1,i) = counter;
    counter=0;
    classVector=[];    
end

meanTotal =mean(trainDataSet(:,1:1:end-1));

%% Sw intra-class scatter matrix Calculation
for i=1:numberOfClass 
   tempMatrix = cell2mat(elementOfEachClass(1,i));
   [samp , ~] = size(tempMatrix);
   meanVec = mean(tempMatrix(:,1:1:end-1));
   if(isnan(meanVec))
      continue; 
   end
   
   for j=1: samp
          Si = Si + ((tempMatrix(j,1:1:end-1)-meanVec(1,:)).' * (tempMatrix(j,1:1:end-1)-meanVec(1,:)));  
   end   
   Sw = Sw + Si;
   Si=zeros(feature,feature);  
%  Sb inter-class scatter matrix Calculation 
   Sb = Sb + (numberOfElementOfEachClass(1,i)*((meanVec(1,:)-meanTotal(1,:)).' *( meanVec(1,:)-meanTotal(1,:))));     
end

%% Calculate A matrix eigenValue and EigenVector matrix
A = inv(Sw)*Sb;
[W,lambda] = eig(A);
lambda =abs(lambda);
W=abs(W);

W_adjusted =zeros(feature ,numberOfClass-1); 

%W matrisi oluşturuldu. c-1 tane en büyük özdeğer için karşılık gelen
%özvektörlerden.

W_adjusted = W(:,1:numberOfClass-1);

%% Project edilmiş data hesabı yapılıyor. 
% 
 Y= zeros(numberOfClass-1 , sample);

for i=1:sample
   Y(:,i) = W_adjusted.' * trainDataSet(i,1:end-1).'; 
end

Y_LDA = Y.';

Y_LDA =[Y_LDA,trainDataSet(:,end)];


end

