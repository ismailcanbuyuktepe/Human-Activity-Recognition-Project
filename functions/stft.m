 function [stftCell, fCell, timeCell] = stft(data,wLength,strWindow,overlap,nfft,fs)

if nargin<2 || nargin<3
   wLength = 128;
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


lengthOfCell = size(data,2);

[window] = windowFunc(wLength,strWindow);

overlap =floor(wLength*overlap);

if overlap == 0
   overlap=wLength; 
end

stftCell = {};
timeCell = {};
fCell = {};

for i=1:lengthOfCell
    cellSize = size(data{i},1);
    rown =ceil((1+nfft)/2);
    coln =1+fix((cellSize-wLength)/overlap);
    stft = zeros(rown,coln); %empty stft image cell
    
    indx =0;
    col=1;
    xn=data{i};
    while indx +wLength <= cellSize
    
    %windowing
    xw = xn(indx+1:indx+wLength,2).*window.';
    
    %FFT
    X = abs(fft(xw,nfft)).^2 / wLength;
    
    stft(:,col)=X(1:rown); % create STFT matix
    
    %update the indexes
    indx =ceil(indx+overlap);
    col=col+1;
      
    end

%calculate the time and frequency vectors

stftCell{i} = stft;
t = (wLength/2:overlap:wLength/2+(coln-1)*overlap)/fs;
timeCell{i} = t;
f = (0:rown-1)*fs/nfft;
fCell{i}=f;


end


end

