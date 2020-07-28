function [win] = windowFunc(wLength,strWindowType)

% Default value is rectangle window
if nargin < 2
   win =  rectangleWindow(wLength);
end

if strWindowType == "rectangle"
    [win] = rectangleWindow(wLength);
    
elseif strWindowType == "hamming"
    [win] = hammingWindow(wLength);
    
elseif strWindowType == "barlett"
    [win] = barlettWindow(wLength);
    
else
    msg1 = "WindowType is a string variable and it just accept that ";
    msg2= "  rectangle , hamming , barlett\n";
    msg3 = "Example usage : windowFunc(128,'hamming') "
    msg = strcat(msg1 , msg2 , msg3) ;
    error(msg);
    
end
    
end

