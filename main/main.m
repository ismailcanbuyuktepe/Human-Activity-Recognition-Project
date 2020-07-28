clc;
clear all;
close all;

%% Folder Configuration
datasetFolder = '..\dataset';
functionFolder= '..\functions';
timeDomainFeatureFolder ='..\functions\FeatureExtractionFunctions\TimeDomain';
freqDomainFeatureFolder ='..\functions\FeatureExtractionFunctions\FrequencyDomain';
filterFunctions= '..\functions\FilterFunctions';
preProcessingFunctions = '..\functions\PreProcessingFunctions';
dimensionRedcutionFunctions = '..\functions\DimensionReductionFunctions';
classificationFunctions = '..\functions\ClassifierFunctions';

addpath(datasetFolder,functionFolder,timeDomainFeatureFolder,freqDomainFeatureFolder,...
    filterFunctions,preProcessingFunctions,dimensionRedcutionFunctions,classificationFunctions);

%% Import DataSets
% data_wal = load('WAL_data.mat');
% data_std = load('STD_data.mat');
% data_jog = load('JOG_data.mat');
% data_jum = load('JUM_data.mat');

%% Parameter Definitions

accFs =87; % Sampling rate of Acc sensor (unit: Hz)
gyroFs=200; % Sampling rate of Gyro sensor (unit : Hz)
wLength = [435,256,218,44] ; % respectively 5 3 2 second window array
nfft =1024;
overlapTime=0.50;
segmentLength=32;
fStop = 15;
numbOfPeak=8;
strWindow = 'hamming'
numbOfClass =4;

%% Walking Data 
%accData_wal = data_wal.data_acc;
%% Standing Data
% accData_std = data_std.data_acc;
%% Jogging Data
% accData_jog = data_jog.data_acc;
%% Jumping Data
% accData_jum = data_jum.data_acc;

%% Time Domain Feature Extraction Part 
% Accolometer data time domain feature extraction (This part run one time.)
% timeDomainFeatureExt(accData_wal,accData_std,accData_jog,accData_jum,wLength,overlapTime);

%% Load Time Feature Matrix
fVec_Timeraw = load('rawTimeDomainFeature_wLngth218_overlap50.mat');            % No outlier Detection
fVec_Timeclean = load('cleanTimeDomainFeature_wLngth218_overlap50.mat');        % Outlier Removal Data

fVec_Timedata = fVec_Timeclean.shuffle_cleanTimeFeature;
trainFVec = fVec_Timedata(1:21128,:);
testFVec = fVec_Timedata(21129:end,:);

pearsonFeatures = corrcoef(trainFVec(:,1:end-1));
tb1 = heatmap (pearsonFeatures);
xlabel('Features') , ylabel('Features');
title("Time Domain Pearson Corr Coef Heat Map");

%% Time Domain Process
%------------------ Nomalization Step for Train Dataset ------------------
normFactor = 1;
[normalizedTrainData,testDatanormParam1,testDatanormParam2] = normalizationFunc(trainFVec,normFactor);

%----------------- PCA Apply on Train data -------------------------------
PCA_dim=3;
[pcaTrainData,W_PCA,~,R_optimal] = calcPCA(normalizedTrainData,PCA_dim);

%----------------- LDA Apply on Train Data -------------------------------
[LDATrainData,W_LDA,lambda] = fisherLDA(normalizedTrainData , numbOfClass);

% --------------- Apply normalization Test Data --------------------------
[normalizedTestData] = normalizationForTestData(testFVec,testDatanormParam1,...
                                testDatanormParam2,normFactor);

% --------------- Apply PCA Test Data ------------------------------------
pcaTestData = applyPCATestData(normalizedTestData,W_PCA,PCA_dim);

% --------------- Apply LDA Test Data ------------------------------------
[LDATestData] = applyLDATestData(normalizedTestData,W_LDA);

%% Time Domain Feature classification
% --------------- k-NN rule Classifier -----------------------------------
k_point = 55;
distanceValue=1;
[accuracy,kNNLabels] = kNNRule(pcaTrainData,pcaTestData,k_point, ...
                                               distanceValue,numbOfClass);             
figure();
cm_kNN = confusionchart(pcaTestData(:,end),kNNLabels,'RowSummary', ...
                    'row-normalized','ColumnSummary','column-normalized');
title('Time Domain kNN k=55 PCA=8 ConfusionMatrix');

% --------------- Perceptron Algorithm ------------------------------------
learningRate = 0.02;
numbOfIteration = 300;
[w,eachClassCell] = keslersReconstruction(LDATrainData,numbOfClass, ...
                                learningRate,numbOfIteration);
[perceptronLabels] = applyPerceptron(LDATestData,w);
[perceptron_accuracy] = perceptronAccuracy(perceptronLabels,LDATestData); 

%---------------- Confusion Matrix --------------------------------------
figure();
cm_Perceptron = confusionchart(LDATestData(:,end),perceptronLabels, ...
                    'RowSummary','row-normalized','ColumnSummary', ...
                    'column-normalized');
title('Perceptron ConfusionMatrix');

