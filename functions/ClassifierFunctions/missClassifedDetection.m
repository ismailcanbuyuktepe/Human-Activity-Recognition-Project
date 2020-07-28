function [misClassifiedMatrix] = missClassifedDetection(w,x)
% This function calculate missclassified x's detection and return x_miss
% So you can calculate your cost function

% input w = weight vector size is (d+1)*c x 1
            % d = number of column of x
            % c = number of class 
%       x = feature vector size  (c-1) x (d+1)*c 

size_x=size(x,1);
misClassifiedMatrix = [];


for i=1:size_x
    temp = w * x(i,:)';
    
    if temp < 0
        misClassifiedMatrix = [misClassifiedMatrix,x(i,:).'];
    else
        continue;
    end
end

end

