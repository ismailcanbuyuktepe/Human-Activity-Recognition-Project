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
wLength = [435,256,218,174] ; % respectively 5 3 2 second window array
nfft =1024;
overlapFreq=0.50;
segmentLength=32;
fStop = 15;
numbOfPeak=8;
strWindow = 'hamming'
numbOfClass =4;

%% Walking Data 
% accData_wal = data_wal.data_acc;
%% Standing Data
% accData_std = data_std.data_acc;
%% Jogging Data
% accData_jog = data_jog.data_acc;
%% Jumping Data
% accData_jum = data_jum.data_acc;

%% Frequency Domain Feature Extraction
% freqDomainFeatureExt(accData_wal,accData_std,accData_jog,accData_jum,...
%                                 wLength(4),strWindow,overlapFreq,nfft,accFs,fStop,numbOfPeak);

%% Load Frequency Domain Feature Matrix
fVec_Freqraw = load('rawFreqDomainFeature_wLngth174_overlap50.mat');
fVec_Freqclean = load('cleanFreqDomainFeature_wLngth174_overlap50.mat');

fVec_Freqdata = fVec_Freqclean.shuffle_cleanFreqFeature;
trainFreqFVec = fVec_Freqdata(1:1343,:);
testFreqFVec = fVec_Freqdata(1344:end,:);

%% Frequency Domain Process
% Nomalization Step for Freq Train Dataset
normFactor = 1;
[normalizedTrainFreqData,testFreqDatanormParam1,testFreqDatanormParam2] = normalizationFunc(trainFreqFVec,normFactor);

% PCA Apply on Train data
PCAFreq_dim=3;
[pcaTrainFreqData,WFreq_PCA,~,Rfreq_optimal] = calcPCA(normalizedTrainFreqData,PCAFreq_dim);

% LDA Apply on Train Data
[LDATrainFreqData,WFreq_LDA,lambda] = fisherLDA(normalizedTrainFreqData,numbOfClass);

% Apply normalization Test Data
[normalizedTestFreqData] = normalizationForTestData(testFreqFVec,testFreqDatanormParam1 ,testFreqDatanormParam2,normFactor);

% Apply PCA Test Data
pcaTestFreqData = applyPCATestData(normalizedTestFreqData,WFreq_PCA,PCAFreq_dim);

% Apply LDA Test Data
[LDATestFreqData] = applyLDATestData(normalizedTestFreqData,WFreq_LDA);

%% Frequency Domain Feature classification
% --------------- k-NN rule Classifier -----------------------------------
k_point = 45;
distanceValue=1;
[accuracy,kNNLabels] = kNNRule(LDATrainFreqData,LDATestFreqData,k_point, ...
                                               distanceValue,numbOfClass);
%---------------- Confusion Matrix ----------------------------------------                                           
figure();
cmkNN = confusionchart(LDATestFreqData(:,end),kNNLabels,'RowSummary','row-normalized','ColumnSummary','column-normalized');
title('k-NN k=11 Frequency Domain ConfusionMatrix for PCA = 3');

% --------------- Perceptron Algorithm ------------------------------------
learningRate = 0.02;
numbOfIteration = 300;
[w,perceptronLabels] = keslersReconstruction(pcaTrainFreqData,numbOfClass, ...
                                learningRate,numbOfIteration);
[classifierLabels] = applyPerceptron(pcaTestFreqData,w);
[perceptron_accuracy] = perceptronAccuracy(classifierLabels,pcaTestFreqData);

%---------------- Confusion Matrix ----------------------------------------
figure();
cm = confusionchart(pcaTestFreqData(:,end),classifierLabels,'RowSummary','row-normalized','ColumnSummary','column-normalized');
title('Perceptron Frequency Domain ConfusionMatrix');


