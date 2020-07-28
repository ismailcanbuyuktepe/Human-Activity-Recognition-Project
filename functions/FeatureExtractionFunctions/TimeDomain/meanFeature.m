function [meanFeatures] = meanFeature(data,wLength,overlap)

% inputParameter : data : A cell array and it include Data for each
%                            participant.
%                  wLength : rectangle Window length (Unit: Sample)

% outputParameter : meanFeatures   : X Y Z axis mean data matrix



lengthOfCell = size(data,2);

xMean = [];
yMean = [];
zMean = [];

%-------------------------------------------------------------------------
% Amount Of Overlap
%-------------------------------------------------------------------------
if overlap == 0
   overlap=wLength;
end
overlap = floor((wLength*overlap));
%-------------------------------------------------------------------------
% To Start Mean calculation for each measurements
%-------------------------------------------------------------------------
for i=1:lengthOfCell
    sgnLength = size(data{i},1);
    dataArr = data{i};
    indx = 0;  
    while indx +wLength <= sgnLength
        temp = mean(dataArr(indx+1:indx+wLength,1));
        xMean=[xMean,temp];
        temp = mean(dataArr(indx+1:indx+wLength,2));
        yMean=[yMean,temp];
        temp = mean(dataArr(indx+1:indx+wLength,3));
        zMean=[zMean,temp];
        %update the indexes
        indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
    end    
end

xMean=xMean.';
yMean=yMean.';
zMean=zMean.';

meanFeatures= [xMean,yMean,zMean];

end

