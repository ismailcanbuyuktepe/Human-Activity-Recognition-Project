function [wHamming] = hammingWindow(wlength)


wHamming =zeros(1,wlength);

for i=1:wlength
   wHamming(1,i) = 0.54 -0.46*cos(2*pi*(i-1)/(wlength)); 
end

end

