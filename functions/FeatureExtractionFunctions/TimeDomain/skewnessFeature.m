function [skewnessMatrix] = skewnessFeature(data,wLength,overlap)

% inputParameter : data : A cell array and it include Data for each
%                            participant.
%                  wLength : rectangle Window length (Unit: Sample)

% outputParameter : skewnessMatrix   : X Y Z axis skewness (third moment) data matrix

lengthOfCell = size(data,2);

skewnessX=[];
skewnessY=[];
skewnessZ=[];

%-------------------------------------------------------------------------
% Amount Of Overlap
%-------------------------------------------------------------------------
if overlap == 0
   overlap=wLength;
end
overlap = floor((wLength*overlap));
%-------------------------------------------------------------------------
% To Start Skewness calculation for each measurements
%-------------------------------------------------------------------------

for i=1:lengthOfCell
   sgnLength = size(data{i},1);
   dataArr = data{i};
   indx = 0;    
   while indx +wLength <= sgnLength
        xn=dataArr(indx+1:indx+wLength,1);
        yn=dataArr(indx+1:indx+wLength,2);
        zn=dataArr(indx+1:indx+wLength,3);
        
        xnSkew = skewness(xn);
        ynSkew = skewness(yn);
        znSkew = skewness(zn);
        
        skewnessX = [skewnessX,xnSkew];
        skewnessY = [skewnessY,ynSkew];
        skewnessZ = [skewnessZ,znSkew];
        %update the indexes
        indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
   end
end

skewnessX=skewnessX.';
skewnessY=skewnessY.';
skewnessZ=skewnessZ.';

skewnessMatrix = [skewnessX,skewnessY,skewnessZ];
end

