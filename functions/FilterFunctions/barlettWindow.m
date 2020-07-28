function [wBarlett] = barlettWindow(wLength)

wBarlett = zeros(1,wLength);

for i=1:wLength
    if i <= (wLength/2)
        wBarlett(1,i)= 2*(i-1)/(wLength-1);
    else
        wBarlett(1,i)= 2 - 2*(i-1)/(wLength-1);
    end   
end


end

