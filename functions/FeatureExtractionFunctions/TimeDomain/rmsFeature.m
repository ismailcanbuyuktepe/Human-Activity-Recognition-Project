function [rmsFeature] = rmsFeature(data,wLength,overlap)
% inputParameter : data : A cell array and it include Data for each
%                         participant.
%                  wLength : rectangle Window length (Unit: Sample)

% outputParameter : rmsFeature  : X Y Z axis rms data matrix

lengthOfCell = size(data,2);

rmsX = [];
rmsY = [];
rmsZ = [];

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
        xn = dataArr(indx+1:indx+wLength,1);
        yn = dataArr(indx+1:indx+wLength,2);
        zn = dataArr(indx+1:indx+wLength,3);
        
        xnRms = rms(xn);
        ynRms = rms(yn);
        znRms = rms(zn);
        
        rmsX = [rmsX xnRms];
        rmsY = [rmsY ynRms];
        rmsZ = [rmsZ znRms];
        %update the indexes
        indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
    end    
end

rmsX=rmsX.';
rmsY=rmsY.';
rmsZ=rmsZ.';

rmsFeature= [rmsX,rmsY,rmsZ];


end

