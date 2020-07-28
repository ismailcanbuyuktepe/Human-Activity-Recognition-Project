function [medianFeatures] = medianFeature(data,wLength,overlap)

% inputParameter : data : A cell array and it include Data for each
%                            participant.
%                  wLength : rectangle Window length (Unit: Sample)

% outputParameter : medianFeatures   : X Y Z axis median data matrix

lengthOfCell = size(data,2);

xMedian = [];
yMedian = [];
zMedian = [];

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

for i=1 : lengthOfCell
   sgnLength = size(data{i},1);
   dataArr = data{i};
   indx = 0;
   while indx +wLength <= sgnLength
        temp = median(dataArr(indx+1:indx+wLength,1));
        xMedian=[xMedian,temp];
        temp = median(dataArr(indx+1:indx+wLength,2));
        yMedian=[yMedian,temp];
        temp = median(dataArr(indx+1:indx+wLength,3));
        zMedian=[zMedian,temp];
        %update the indexes
        indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
   end
end

xMedian=xMedian.';
yMedian=yMedian.';
zMedian=zMedian.';

medianFeatures= [xMedian,yMedian,zMedian];  
    

end

