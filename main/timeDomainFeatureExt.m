function [] = timeDomainFeatureExt(accData_wal,accData_std,accData_jog,accData_jum,wLength,overlap)
%% Feature Extraction part Time Domain

% Walking data feature extraction
%Acc x y z axis mean matrix
[wal_accMeanFeatures] = meanFeature(accData_wal,wLength(3),overlap);
% %Acc x y z axis std matrix
[wal_accstdFeatures] = stdFeature(accData_wal,wLength(3),overlap);
% %Acc x y z axis max min matrix
[wal_maxFeature,wal_minFeature] = boundaryValueFeature(accData_wal,wLength(3),overlap);
% %Acc x y z axis median matrix
[wal_accmedianFeatures] = medianFeature(accData_wal,wLength(3),overlap);
% %Acc x y z axis zero cross rate matrix
[wal_acczcrFeature] = zeroCrossRate(accData_wal,wLength(3),overlap);
% %Acc x y z axis rms matrix
[wal_accrmsFeature] = rmsFeature(accData_wal,wLength(3),overlap);
% %Acc x y z axis skewness matrix
[wal_accskewnessFeature] = skewnessFeature(accData_wal,wLength(3),overlap);
% %Acc x y z axis kurtosis matrix
[wal_acckurtosisFeature] = kurtosisFeature(accData_wal,wLength(3),overlap);
% %Acc x y z ar(2) model feature
[wal_accArCoeffFeature] = armodel(accData_wal,wLength(3),overlap,2);

%-------------------------------------------------------------------------
% Standing data feature extraction
[std_accMeanFeatures] = meanFeature(accData_std,wLength(3),overlap);
% %Acc x y z axis std matrix
[std_accstdFeatures] = stdFeature(accData_std,wLength(3),overlap);
% %Acc x y z axis max min matrix
[std_maxFeature,std_minFeature] = boundaryValueFeature(accData_std,wLength(3),overlap);
% %Acc x y z axis median matrix
[std_accmedianFeatures] = medianFeature(accData_std,wLength(3),overlap);
% %Acc x y z axis zero cross rate matrix
[std_acczcrFeature] = zeroCrossRate(accData_std,wLength(3),overlap);
% %Acc x y z axis rms matrix
[std_accrmsFeature] = rmsFeature(accData_std,wLength(3),overlap);
% %Acc x y z axis skewness matrix
[std_accskewnessFeature] = skewnessFeature(accData_std,wLength(3),overlap);
% %Acc x y z axis kurtosis matrix
[std_acckurtosisFeature] = kurtosisFeature(accData_std,wLength(3),overlap);
% %Acc x y z ar(2) model feature
[std_accArCoeffFeature] = armodel(accData_std,wLength(3),overlap,2);
%--------------------------------------------------------------------------

% Jogging data feature extraction
%Acc x y z axis mean matrix
[jog_accMeanFeatures] = meanFeature(accData_jog,wLength(3),overlap);
% %Acc x y z axis std matrix
[jog_accstdFeatures] = stdFeature(accData_jog,wLength(3),overlap);
% %Acc x y z axis max min matrix
[jog_maxFeature,jog_minFeature] = boundaryValueFeature(accData_jog,wLength(3),overlap);
% %Acc x y z axis median matrix
[jog_accmedianFeatures] = medianFeature(accData_jog,wLength(3),overlap);
% %Acc x y z axis zero cross rate matrix
[jog_acczcrFeature] = zeroCrossRate(accData_jog,wLength(3),overlap);
% %Acc x y z axis rms matrix
[jog_accrmsFeature] = rmsFeature(accData_jog,wLength(3),overlap);
% %Acc x y z axis skewness matrix
[jog_accskewnessFeature] = skewnessFeature(accData_jog,wLength(3),overlap);
% %Acc x y z axis kurtosis matrix
[jog_acckurtosisFeature] = kurtosisFeature(accData_jog,wLength(3),overlap);
% %Acc x y z ar(2) model feature
[jog_accArCoeffFeature] = armodel(accData_jog,wLength(3),overlap,2);
% -------------------------------------------------------------------------

%Jumpping data feature extraction

%Acc x y z axis mean matrix
[jum_accMeanFeatures] = meanFeature(accData_jum,wLength(3),overlap);
% %Acc x y z axis std matrix
[jum_accstdFeatures] = stdFeature(accData_jum,wLength(3),overlap);
% %Acc x y z axis max min matrix
[jum_maxFeature,jum_minFeature] = boundaryValueFeature(accData_jum,wLength(3),overlap);
% %Acc x y z axis median matrix
[jum_accmedianFeatures] = medianFeature(accData_jum,wLength(3),overlap);
% %Acc x y z axis zero cross rate matrix
[jum_acczcrFeature] = zeroCrossRate(accData_jum,wLength(3),overlap);
% %Acc x y z axis rms matrix
[jum_accrmsFeature] = rmsFeature(accData_jum,wLength(3),overlap);
% %Acc x y z axis skewness matrix
[jum_accskewnessFeature] = skewnessFeature(accData_jum,wLength(3),overlap);
% %Acc x y z axis kurtosis matrix
[jum_acckurtosisFeature] = kurtosisFeature(accData_jum,wLength(3),overlap);
% %Acc x y z ar(2) model feature
[jum_accArCoeffFeature] = armodel(accData_jum,wLength(3),overlap,2);

%%  Time Domain Data Visulazation
% plotFeature(wal_accMeanFeatures,wal_accstdFeatures,wal_accmedianFeatures,...
%     wal_acczcrFeature,wal_accrmsFeature,wal_accskewnessFeature,wal_acckurtosisFeature);

%% Feature vectors 
[wal_length] =size(wal_accMeanFeatures,1);
std_length =size(std_accMeanFeatures,1);
jog_length =size(jog_accMeanFeatures,1);
jum_length =size(jum_accMeanFeatures,1);

vec1 = [wal_accMeanFeatures,wal_accstdFeatures,wal_maxFeature,wal_minFeature, ...
    wal_accmedianFeatures,wal_acczcrFeature,...
    wal_accrmsFeature,wal_accskewnessFeature,wal_acckurtosisFeature, ...
    wal_accArCoeffFeature];

vec2 = [std_accMeanFeatures,std_accstdFeatures,std_maxFeature,std_minFeature, ...
    std_accmedianFeatures,std_acczcrFeature,...
    std_accrmsFeature,std_accskewnessFeature,std_acckurtosisFeature, ...
    std_accArCoeffFeature];

vec3 =[jog_accMeanFeatures,jog_accstdFeatures,jog_maxFeature,jog_minFeature, ...
    jog_accmedianFeatures,jog_acczcrFeature,...
    jog_accrmsFeature,jog_accskewnessFeature,jog_acckurtosisFeature, ...
    jog_accArCoeffFeature];

vec4 =[jum_accMeanFeatures,jum_accstdFeatures,jum_maxFeature,jum_minFeature, ...
    jum_accmedianFeatures,jum_acczcrFeature,...
    jum_accrmsFeature,jum_accskewnessFeature,jum_acckurtosisFeature, ...
    jum_accArCoeffFeature];

%% Outlier Removal 
cleanVec1 = rmoutliers(vec1,'mean');
cleanVec2 = rmoutliers(vec2,'mean');
cleanVec3 = rmoutliers(vec3,'mean');
cleanVec4 = rmoutliers(vec4,'mean');

vec1 = [vec1,ones(wal_length,1)];
vec2 = [vec2,2*ones(std_length,1)];
vec3 = [vec3,3*ones(jog_length,1)];
vec4 = [vec4,4*ones(jum_length,1)];

cleanVec1 = [cleanVec1,ones(size(cleanVec1,1),1)];
cleanVec2 = [cleanVec2,2*ones(size(cleanVec2,1),1)];
cleanVec3 = [cleanVec3,3*ones(size(cleanVec3,1),1)];
cleanVec4 = [cleanVec4,4*ones(size(cleanVec4,1),1)];

rawTimeFeature = [vec1;vec2;vec3;vec4];
shuffle_rawTimeFeature = rawTimeFeature(randperm(end),:);
cleanTimeFeature = [cleanVec1;cleanVec2;cleanVec3;cleanVec4];
shuffle_cleanTimeFeature = cleanTimeFeature(randperm(end),:);


filename_1='rawTimeDomainFeature_wLngth218_overlap50.mat';
filename_2='cleanTimeDomainFeature_wLngth218_overlap50.mat';
save( filename_1, 'shuffle_rawTimeFeature' );
save( filename_2, 'shuffle_cleanTimeFeature' );
end

