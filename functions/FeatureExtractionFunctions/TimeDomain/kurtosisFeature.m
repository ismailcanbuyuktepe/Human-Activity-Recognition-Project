function [kurtosisMatrix] = kurtosisFeature(data,wLength,overlap)
% inputParameter : data : A cell array and it include Data for each
%                            participant.
%                  wLength : rectangle Window length (Unit: Sample)
%                  overlap : percent of overlap (like as %50 overlap)

% outputParameter : kurtosisMatrix   : X Y Z axis kurtosis (forth moment) data matrix

lengthOfCell = size(data,2);

kurtosisX=[];
kurtosisY=[];
kurtosisZ=[];

%-------------------------------------------------------------------------
% Amount Of Overlap
%-------------------------------------------------------------------------
if overlap == 0
   overlap=wLength;
end
overlap = floor((wLength*overlap));
%-------------------------------------------------------------------------
% To Start Kurtosis calculation for each measurements
%-------------------------------------------------------------------------

for i=1:lengthOfCell
   sgnLength = size(data{i},1);
   dataArr = data{i};
   indx=0;  
   while indx+wLength <= sgnLength
        xn=dataArr(indx+1:indx+wLength,1);
        yn=dataArr(indx+1:indx+wLength,2);
        zn=dataArr(indx+1:indx+wLength,3);
        
        xnKurtosis = kurtosis(xn);
        ynKurtosis = kurtosis(yn);
        znKurtosis = kurtosis(zn);
        
        kurtosisX = [kurtosisX,xnKurtosis];
        kurtosisY = [kurtosisY,ynKurtosis];
        kurtosisZ = [kurtosisZ,znKurtosis];
        %update the indexes
        indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
   end   
end

kurtosisX=kurtosisX.';
kurtosisY=kurtosisY.';
kurtosisZ=kurtosisZ.';

kurtosisMatrix = [kurtosisX,kurtosisY,kurtosisZ];
end

