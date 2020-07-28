function [maxFeature,minFeature] = psdWelchMaxMinFeature(data)

lengthOfCell = size(data,2);

xMax = [];
yMax = [];
zMax = [];

xMin = [];
yMin = [];
zMin = [];


for i=1:lengthOfCell
   xn = data{i};
   maxTemp = 10*log10(max(xn(:,1)));
   minTemp = 10*log10(min(xn(:,1)));
   xMax =[xMax,maxTemp];
   xMin =[xMin,minTemp];
   maxTemp = 10*log10(max(xn(:,2)));
   minTemp = 10*log10(min(xn(:,2)));    
   yMax =[yMax,maxTemp];
   yMin =[yMin,minTemp];
   maxTemp = 10*log10(max(xn(:,3)));
   minTemp = 10*log10(min(xn(:,3)));    
   zMax =[zMax,maxTemp];
   zMin =[zMin,minTemp];   
end

xMax = xMax.';
yMax = yMax.';
zMax = zMax.';

xMin=xMin.';
yMin=yMin.';
zMin=zMin.';

maxFeature = [xMax,yMax,zMax];
minFeature = [xMin,yMin,zMin];

end