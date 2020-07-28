function [newDataCell] = recalcFreqFeatureMatrix(data,segmentLength)

newDataCell = {};
xsl = [];

lengthOfCell = size(data,2);
totalSegment =0;

for i=1:lengthOfCell
   xn = data{i};
   xnSize = size(xn,1);
   numbOfSegment = floor (xnSize/segmentLength);
   for j=1:numbOfSegment
      xsl = xn((j-1)*segmentLength+1:j*segmentLength,:); 
      newDataCell{j+totalSegment} = xsl;
      xsl =0;
   end
   totalSegment = numbOfSegment+totalSegment; 
end

end

