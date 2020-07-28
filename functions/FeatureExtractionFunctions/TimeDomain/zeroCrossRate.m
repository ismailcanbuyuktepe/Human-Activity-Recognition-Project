function [zcrFeature] = zeroCrossRate(data,wLength,overlap)
% inputParameter : data : A cell array and it include Data for each
%                            participant.
%                  wLength : rectangle Window length (Unit: Sample)

% outputParameter : zcrFeature   : X , Y , Z axis zero cross rate matrix

lengthOfCell = size(data,2);

xZcr = [];
yZcr = [];
zZcr = [];

%-------------------------------------------------------------------------
% Amount Of Overlap
%-------------------------------------------------------------------------
if overlap == 0
   overlap=wLength;
end
overlap = floor((wLength*overlap));
%-------------------------------------------------------------------------
% To Start Mean calculation for each measurements
%-------------------------------------------------------------------------

for i=1 : lengthOfCell
    sgnLength = size(data{i},1);
    dataArr = data{i};
    indx = 0;
    while indx +wLength <= sgnLength
        temp= mean(abs(diff(sign(dataArr(indx+1:indx+wLength,1)))));
        xZcr=[xZcr,temp];
        temp= mean(abs(diff(sign(dataArr(indx+1:indx+wLength,2)))));
        yZcr=[yZcr,temp];
        temp = mean(abs(diff(sign(dataArr(indx+1:indx+wLength,3)))));
        zZcr=[zZcr,temp];
        %update the indexes
        indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
    end    
end

xZcr=xZcr.';
yZcr=yZcr.';
zZcr=zZcr.';

zcrFeature= [xZcr,yZcr,zZcr];


end

