function [peakMatrix] = psdWelchPeakFeature(data,numbOfPeak)

% Definition : This function calculates max welch psd estimation amplitude.
% Input Parameter :  data : welch PSD signal for each subjects.Because of
%                           data is a cellArry
%                    numbOfPeak : How much peak dou you want.

lengthOfCell = size(data,2);

xPeakArr =[];
yPeakArr =[];
zPeakArr =[];

for i=1:lengthOfCell
    xn = data{i};
    sgnAxis = size(xn,2);
    for j=1:sgnAxis
        peak = 10*log10(findpeaks(xn(:,j))).';
        if(length(peak)<numbOfPeak)
            numbOfPeak = length(peak);
        end
        peak = peak(1:numbOfPeak);
        if j == 1
            xPeakArr = [xPeakArr;peak];
            peak =[];
        elseif j==2
            yPeakArr = [yPeakArr;peak]; 
            peak=[];
        else
            zPeakArr = [zPeakArr;peak];
            peak=[];   
        end       
    end  
end

peakMatrix = [xPeakArr,yPeakArr,zPeakArr];

end





