function [maxFeature,minFeature] = boundaryValueFeature(data,wLength,overlap)

lengthOfCell = size(data,2);

xMax=[];
yMax=[];
zMax=[];

xMin=[];
yMin=[];
zMin=[];



%-------------------------------------------------------------------------
% Amount Of Overlap
%-------------------------------------------------------------------------
if overlap == 0
   overlap=wLength;
end
overlap = floor((wLength*overlap));
%-------------------------------------------------------------------------
% To Start Max Min calculation for each measurements
%-------------------------------------------------------------------------

for i=1:lengthOfCell
    sgnLength = size(data{i},1);
    dataArr = data{i};
    indx = 0;  
    while indx + wLength <= sgnLength
        maxTemp = max(dataArr(indx+1:indx+wLength,1));
        minTemp = min(dataArr(indx+1:indx+wLength,1));
        xMax=[xMax,maxTemp];
        xMin=[xMin,minTemp];
        maxTemp = max(dataArr(indx+1:indx+wLength,2));
        minTemp = min(dataArr(indx+1:indx+wLength,2));
        yMax=[yMax,maxTemp];
        yMin=[yMin,minTemp];
        maxTemp = max(dataArr(indx+1:indx+wLength,3));
        minTemp = min(dataArr(indx+1:indx+wLength,3));
        zMax = [zMax,maxTemp];
        zMin = [zMin,minTemp];
        %update the indexes
        indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
    end    
end

xMax=xMax.';
yMax=yMax.';
zMax=zMax.';

xMin=xMin.';
yMin=yMin.';
zMin=zMin.';

maxFeature = [xMax,yMax,zMax];
minFeature = [xMin,yMin,zMin];

end

