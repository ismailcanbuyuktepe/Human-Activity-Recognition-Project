function [meanFeature] = psdWelchMeanValue(data,fStop,nfft,fs)

lengthOfCell = size(data,2);

xMean = [];
yMean = [];
zMean = [];

targetSample=0;

for i=1:(nfft/2)
    k=(fs/nfft)*(i-1)
    if(k<=fStop)
        targetSample = targetSample+1;
    else
        break;
    end
end

for i=1:lengthOfCell
   xn = data{i};
   meanTemp = 10*log10(mean(xn(1:targetSample,1)));
   xMean =[xMean,meanTemp];   
   meanTemp = 10*log10(mean(xn(1:targetSample,2)));
   yMean =[yMean,meanTemp];
   meanTemp = 10*log10(mean(xn(1:targetSample,3)));
   zMean =[zMean,meanTemp];   
end

xMean = xMean.';
yMean = yMean.';
zMean = zMean.';

meanFeature = [xMean,yMean,zMean];

end
