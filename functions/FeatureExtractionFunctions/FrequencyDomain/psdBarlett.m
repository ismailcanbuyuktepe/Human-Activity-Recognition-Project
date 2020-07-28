function [pBarlettCell] = psdBarlett(data,wLength,strWindow,nfft,fs)

%% Default Argument Control Step
if nargin <2 || nargin<3
    wLength = 256
    window = windowFunc(wLength,"rectangle");
end

if(nargin<4 || (mod(nfft,2) ~= 0))
    nfft = 1024;
end

if nargin <5
   fs=87 
end

%% Barlett PSD Estimation

lengthOfCell = size(data,2);

%-------------------------------------------------------------------------
% Windowing Process
%-------------------------------------------------------------------------
[window] = windowFunc(wLength,strWindow);

% ------------------------------------------------------------------------
% To Start Barlett PSD estimation calculation for each measurements
% ------------------------------------------------------------------------

pBarlett = [];
pBarlettCell = {};

for i=1:lengthOfCell
    sgnLength = size (data{i},1);
    sgnAxisLength = size(data{i},2);
    xn = data{i};
    for j=1:sgnAxisLength
        indx = 0;
        xm=xn(:,j);
        X_sum = 0;
        segmentValue = 0;
        
        while indx + wLength <= sgnLength        
            %windowing
            xw = xm(indx+1:indx+wLength,1).*window.';
            X = abs(fft(xw,nfft)).^2;
            X_sum = X_sum + X(1:ceil((1+nfft)/2)) ;
            segmentValue = segmentValue +1;
            %update the indexes.
            indx = indx + wLength;
        end
        pBarlett(:,j) = X_sum(:,1)/(segmentValue*wLength);
    end
    pBarlettCell{i} = pBarlett;
end
end
