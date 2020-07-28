function [pWelchCell] = psdWelch(data,wLength,strWindow,overlap,nfft,fs)

%% default Argument Control Step
if nargin<2 || nargin<3
   wLength = 246;
   window = windowFunc(wLength,"rectangle");
end

if(overlap<0 || overlap>1) ||(nargin<4)
   overlap=0.5  %default overlap parameter %50;
end

if nargin<5 || (mod(nfft,2)~=0)
    nfft = 1024;  %default nfft parameter 1024
end

if nargin<6
   fs=87;   %default fs parameter 87
end

%% Welch PSD estimation 

lengthOfCell = size(data,2);
% ------------------------------------------------------------------------
% Window process
% ------------------------------------------------------------------------
[window] = windowFunc(wLength,strWindow);
counterWindow = 0;
for m=1:wLength
    counterWindow = counterWindow+abs(window(1,m));
end

P =1/wLength * counterWindow ;
%-------------------------------------------------------------------------
% Amount Of Overlap
%-------------------------------------------------------------------------
if overlap == 0
    overlap=wLength;
else
    overlap = floor(wLength*overlap);
end
%-------------------------------------------------------------------------
% To Start Welch PSD calculation for each measurements
%-------------------------------------------------------------------------
pWelch =[];
pWelchCell = {};
for i=1:lengthOfCell
    sgnLength = size(data{i},1);
    sgnAxisLength = size(data{i},2);
    xn =data{i};
    for j=1:sgnAxisLength
        indx = 0;       
        xm=xn(:,j);
        X_sum = 0;
        segmentValue =0;
        while indx + wLength <= sgnLength
            
            %windowing
            xw = xm(indx+1:indx+wLength,1).*window.';
            
            X =abs(fft(xw,nfft)).^2 /wLength;
            X = (1/P)*X();
            
            X_sum = X_sum+X(1:ceil((1+nfft)/2));
            segmentValue =segmentValue+1;
            
            %update the indexes
            indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
        end
        
        pWelch(:,j)= X_sum(:,1)/segmentValue;  
    end
    pWelchCell{i} = pWelch;
end
end

