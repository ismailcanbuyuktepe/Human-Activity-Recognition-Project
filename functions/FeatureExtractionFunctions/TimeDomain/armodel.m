function [arCoeff] = armodel(data,wLength,overlap,numbOfLag)

% inputParameter : data : A cell array and it include Data for each
%                            participant.
%                  wLength : rectangle Window length (Unit: Sample)
%                  overlap : percent of overlap (like as %50 overlap)
%                  numbOfLag: order of ar model

% outputParameter : meanFeatures   : X Y Z axis ar model Coeff data matrix

arCoef_x=[];
arCoef_y=[];
arCoef_z=[];
arCoeff=[];
ar=[];
lengthOfCell = size(data,2);

%-------------------------------------------------------------------------
% Amount Of Overlap
%-------------------------------------------------------------------------
if overlap == 0
   overlap=wLength;
end
overlap = floor((wLength*overlap));
%-------------------------------------------------------------------------
% To Start AR Model Coefficient calculation for each measurements
%-------------------------------------------------------------------------
for i=1:lengthOfCell
    sgnLength = size(data{i},1);
    axisLength= size(data{i},2);
    dataArr = data{i};
    indx=0;
   for j=1:axisLength 
        while indx+wLength <= sgnLength
            xn=dataArr(indx+1:indx+wLength,j); 
            r=xcorr(xn,xn);
            r=r/max(r);
            rr = r(wLength:(wLength+numbOfLag-1));
            %-------------------------------------------------
            % Choose ar model order criteria ( Levinson-Durbin method)
            %-------------------------------------------------
%                 rrt=r(wLength:end);
%                 maxOrd = 50;
%                 El = zeros(1, maxOrd);
%                 for m = 1:maxOrd
%                 [a, e, ~] = levinson(rrt,m);
%                 El(m) = e;
%                 end
%                 figure
%                 plot(1:maxOrd, El);
            %------------------------------------------------
            % End of chosing of ar model order criteria
            %------------------------------------------------
            R=toeplitz(rr);
            p=r(wLength+1:wLength+numbOfLag);
            a = inv(R)*p;
            a=-a.';
            %aa=[1,a];
            ar=[ar;a];
            indx =ceil(indx+(wLength-overlap)); % (wLength-overlap) term is called hop size %
        end
        if j==1
            arCoef_x=[arCoef_x;ar];
            ar=[];
            indx=0;
        elseif j==2
            arCoef_y=[arCoef_y;ar];
            ar=[];
            indx=0;
        else
            arCoef_z=[arCoef_z;ar];
            ar=[];
            indx=0;
        end       
   end  
end

arCoeff=[arCoef_x,arCoef_y,arCoef_z];

end

