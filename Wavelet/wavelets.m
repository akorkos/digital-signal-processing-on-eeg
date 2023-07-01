load EEG_Blinking.mat

y = eeg1;
Ts = 1/Fs;
t = 1:numel(y);
time = Ts*t;

% Wavelet De-Noising

db4 = wdenoise(y,8,'Wavelet','db4', DenoisingMethod="UniversalThreshold",ThresholdRule="soft", NoiseEstimate="LevelDependent");
db6 = wdenoise(y,8,'Wavelet','db6', DenoisingMethod="UniversalThreshold", ThresholdRule="soft", NoiseEstimate="LevelDependent");
db8 = wdenoise(y,8,'Wavelet','db8', DenoisingMethod="UniversalThreshold",ThresholdRule="soft", NoiseEstimate="LevelDependent");
dmey = wdenoise(y,8,'Wavelet','dmey', DenoisingMethod="UniversalThreshold",ThresholdRule="soft", NoiseEstimate="LevelDependent");

% RMS Difference Calculation

rms_db4 = rmse(db4, y)
rms_db6 = rmse(db6, y)
rms_db8 = rmse(db8, y)
rms_dmey = rmse(dmey, y)

% Plot

figure(1);
subplot(5,1,1); plot(time, y); title('Noisy Signal'); xlabel("Sample"); ylabel("Amplitude");
subplot(5,1,2); plot(time, db4); title('De-noised by WF db4'); xlabel("Sample"); ylabel("Amplitude");
subplot(5,1,3); plot(time, db6); title('De-noised by WF db6'); xlabel("Sample"); ylabel("Amplitude");
subplot(5,1,4); plot(time, db8); title('De-noised by WF db8'); xlabel("Sample"); ylabel("Amplitude");
subplot(5,1,5); plot(time, dmey); title('De-noised by WF dmey'); xlabel("Sample"); ylabel("Amplitude");

