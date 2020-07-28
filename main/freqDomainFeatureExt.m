function [] = freqDomainFeatureExt(accData_wal,accData_std,accData_jog,accData_jum,...
                                wLength,strWindow,overlap,nfft,fs,fStop,numbOfPeak)

% This function calculate welch psd estimation and choise 8 peak value for
% each axis and also max min and mean spectral value. As second step
% ,outlier removal is done. The final step is data shuffle and save dataset
% as a mat file.
% If you can run this function one time. You can called as filename_1 in main
% script.
                         
% all features were recalculated to be of equal size.
segment1=2610;
segment2=870;

[accData_wal] = recalcFreqFeatureMatrix(accData_wal,segment1); 
[accData_std] = recalcFreqFeatureMatrix(accData_std,segment1); 
[accData_jog] = recalcFreqFeatureMatrix(accData_jog,segment2); 
[accData_jum] = recalcFreqFeatureMatrix(accData_jum,segment2); 
                            
%% Frequency Domain Feature Extraction
[wal_Welch] = psdWelch(accData_wal,wLength,strWindow,overlap,nfft,fs);
[std_Welch] = psdWelch(accData_std,wLength,strWindow,overlap,nfft,fs);
[jog_Welch] = psdWelch(accData_jog,wLength,strWindow,overlap,nfft,fs);
[jum_Welch] = psdWelch(accData_jum,wLength,strWindow,overlap,nfft,fs);

freq = 0:fs/nfft:fs/2;
for i=1:5 
    wlch = jog_Welch{i};
    
    wlch_x = wlch(:,1);
    wlch_y = wlch(:,2);
    wlch_z = wlch(:,3);
    
    figure(i),
    plot(freq,10*log10(wlch_x));
    hold on,
    plot(freq,10*log10(wlch_y));
    hold on,
    plot(freq,10*log10(wlch_z));title("Welch JOG");
    hold off;
    xlabel('frequency (Hz)'),ylabel('PSD (dB)');
    legend('x axis acc','y axis acc','z axis acc');
end

for j=1:5 
    wlch2 = jum_Welch{j};
    
    wlch2_x = wlch2(:,1);
    wlch2_y = wlch2(:,2);
    wlch2_z = wlch2(:,3);
    
    figure(j+i),
    plot(freq,10*log10(wlch2_x));
    hold on,
    plot(freq,10*log10(wlch2_y));
    hold on,
    plot(freq,10*log10(wlch2_z));title("Welch JUM");
    hold off;
    xlabel('frequency (Hz)'),ylabel('PSD (dB)');
    legend('x axis acc','y axis acc','z axis acc');
end

 [stftCell, fCell, tCell] = stft(accData_wal,wLength,strWindow,overlap,nfft,fs);
% 
% stftCellSize = size(stftCell,2);

for i=1:2
   s =stftCell{i};
   s=10*log10(s);
   
   t=tCell{i};
   f=fCell{i};
   
   figure();
   imagesc(t(1:3),f(5:end),s);
   set(gca,'YDir','normal')
   set(gca, 'FontName', 'Times New Roman', 'FontSize', 10)
   xlabel('Time, s')
   ylabel('Frequency, Hz')
   title('Amplitude spectrogram of the signal');

   handl = colorbar;
   set(handl, 'FontName', 'Times New Roman', 'FontSize', 10)
   ylabel(handl, 'Magnitude, dB')
   
   saveas(gcf,['filename' num2str(i) '.png']);
       
end



[wal_maxFeature,wal_minFeature] = psdWelchMaxMinFeature(wal_Welch);
[wal_meanFeature] = psdWelchMeanValue(wal_Welch,fStop,nfft,fs);
[std_maxFeature,std_minFeature] = psdWelchMaxMinFeature(std_Welch);
[std_meanFeature] = psdWelchMeanValue(std_Welch,fStop,nfft,fs);
[jog_maxFeature,jog_minFeature] = psdWelchMaxMinFeature(jog_Welch);
[jog_meanFeature] = psdWelchMeanValue(jog_Welch,fStop,nfft,fs);
[jum_maxFeature,jum_minFeature] = psdWelchMaxMinFeature(jum_Welch);
[jum_meanFeature] = psdWelchMeanValue(jum_Welch,fStop,nfft,fs);


[wal_peakFeature] = psdWelchPeakFeature(wal_Welch,numbOfPeak);
[std_peakFeature] = psdWelchPeakFeature(std_Welch,numbOfPeak);
[jog_peakFeature] = psdWelchPeakFeature(jog_Welch,numbOfPeak);
[jum_peakFeature] = psdWelchPeakFeature(jum_Welch,numbOfPeak);
                            
%% Create Feature Matrix

[wal_length] =size(wal_maxFeature,1);
std_length =size(std_maxFeature,1);
jog_length =size(jog_maxFeature,1);
jum_length =size(jum_maxFeature,1);

vec1 = [wal_maxFeature,wal_minFeature,wal_meanFeature,wal_peakFeature];
vec2 = [std_maxFeature,std_minFeature,std_meanFeature,std_peakFeature];
vec3 = [jog_maxFeature,jog_minFeature,jog_meanFeature,jog_peakFeature];
vec4 = [jum_maxFeature,jum_minFeature,jum_meanFeature,jum_peakFeature];

%% Outlier Removal
cleanVec1 = rmoutliers(vec1,'mean');
cleanVec2 = rmoutliers(vec2,'mean');
cleanVec3 = rmoutliers(vec3,'mean');
cleanVec4 = rmoutliers(vec4,'mean');

% -------------------------------------
vec1 = [vec1,ones(wal_length,1)];
vec2 = [vec2,2*ones(std_length,1)];
vec3 = [vec3,3*ones(jog_length,1)];
vec4 = [vec4,4*ones(jum_length,1)];

cleanVec1 = [cleanVec1,ones(size(cleanVec1,1),1)];
cleanVec2 = [cleanVec2,2*ones(size(cleanVec2,1),1)];
cleanVec3 = [cleanVec3,3*ones(size(cleanVec3,1),1)];
cleanVec4 = [cleanVec4,4*ones(size(cleanVec4,1),1)];

rawFreqFeature = [vec1;vec2;vec3;vec4];
shuffle_rawFreqFeature = rawFreqFeature(randperm(end),:);
cleanFreqFeature = [cleanVec1;cleanVec2;cleanVec3;cleanVec4];
shuffle_cleanFreqFeature = cleanFreqFeature(randperm(end),:);

filename_1='rawFreqDomainFeature_wLngth174_overlap50.mat';
filename_2='cleanFreqDomainFeature_wLngth174_overlap50.mat';
save( filename_1, 'shuffle_rawFreqFeature' );
save( filename_2, 'shuffle_cleanFreqFeature' );

%% Frequency Domain Signal Analysis
% [pWelchCell] = psdWelch(accData_wal,wLength(2),"hamming",overlap,nfft,accFs);
% 
% freq = 0:accFs/nfft:accFs/2;
% for i=1:size(pWelchCell,2) 
%     psdWelch = pWelchCell{i};
%     
%     psdWelch_x = psdWelch(:,1);
%     psdWelch_y = psdWelch(:,2);
%     psdWelch_z = psdWelch(:,3);
%     
%     figure(i),
%     plot(freq,10*log10(psdWelch_x));
%     hold on,
%     plot(freq,10*log10(psdWelch_y));
%     hold on,
%     plot(freq,10*log10(psdWelch_z));title("Welch");
%     hold off;
%     xlabel('frequency (Hz)'),ylabel('PSD (dB)');
%     legend('x axis acc','y axis acc','z axis acc');
% end

%% Time-frequency Analysis
%  [stftCell, fCell, tCell] = stft(accData_wal,wLength(2),"hamming",overlap,nfft,accFs);
% % 
% stftCellSize = size(stftCell,2);
% 
% for i=1:stftCellSize
%    s =stftCell{i};
%    s=10*log10(s);
%    
%    t=tCell{i};
%    f=fCell{i};
%    
%    figure();
%    imagesc(t,f(5:end),s);
%    set(gca,'YDir','normal')
%    set(gca, 'FontName', 'Times New Roman', 'FontSize', 10)
%    xlabel('Time, s')
%    ylabel('Frequency, Hz')
%    title('Amplitude spectrogram of the signal');
% 
%    handl = colorbar;
%    set(handl, 'FontName', 'Times New Roman', 'FontSize', 10)
%    ylabel(handl, 'Magnitude, dB')
%    
%    saveas(gcf,['filename' num2str(i) '.png']);
%        
% end


%% Feature Extraction part Frequency Domain

% [accCellXPeakArr,accCellYPeakArr,accCellZPeakArr] = psdWelchFeature(accData_wal,segmentLength,nfft)
% 
% xSize = 0;
% ySize = 0;
% zSize = 0;
% 
% for i=1:61
%    x = accCellXPeakArr{i};
%    y = accCellYPeakArr{i};
%    z = accCellZPeakArr{i};
%    xSize = xSize + size(x,1);
%    ySize = ySize + size(y,1);
%    zSize = zSize + size(z,1);
% end

end

