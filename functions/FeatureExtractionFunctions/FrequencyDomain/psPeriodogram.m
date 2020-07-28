function [psdperi] = psPeriodogram(xn,nfft,pStart,pEnd)

if nargin<2
   nfft =2048; 
end

if nargin <3
    pStart =1;
    pEnd = length(xn);
end

xn= xn(pStart:pEnd);
xdft = abs(fft(xn,nfft)).^2;
xdft = xdft(1:floor(nfft/2)+1);
psdperi = 1/(pEnd-pStart+1) * xdft ;

end

