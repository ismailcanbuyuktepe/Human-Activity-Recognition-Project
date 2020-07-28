function [stdFeatures] = stdFeature(data,wLength,overlap)

% inputParameter : data : A cell array and it include Data for each
%                            participant.
%                  wLength : rectangle Window length (Unit: Sample)

% outputParameter : xAcc   : X axis std data 
%                   yAcc   : Y axis std data
%                   zAcc   : Z axis std data

lengthOfCell = size(data,2);

xStd = [];
yStd = [];
zStd = [];

%-------------------------------------------------------------------------
% Amount Of Overlap
%-------------------------------------------------------------------------
if overlap == 0
   overlap=wLength;
end
overlap = floor((wLength*overlap));
%-------------------------------------------------------------------------
% To Start Standart Deviation calculation for each measurements
%-------------------------------------------------------------------------
for i=1 : lengthOfCell
    sgnLength = size(data{i},1);
    dataArr = data{i};
    indx = 0;
    while indx +wLength <= sgnLength
        temp = std(dataArr(indx+1:indx+wLength,1));
        xStd=[xStd,temp];
        temp = std(dataArr(indx+1:indx+wLength,2));
        yStd=[yStd,temp];
        temp = std(dataArr(indx+1:indx+wLength,3));
        zStd=[zStd,temp];
        %update the indexes
        indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
    end    
end

xStd=xStd.';
yStd=yStd.';
zStd=zStd.';

stdFeatures= [xStd,yStd,zStd];

end

