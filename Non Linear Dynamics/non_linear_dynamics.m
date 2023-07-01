%% Provide a NonLinear Dynamics description as a function of brain-rhythms. 
load EEG_data.mat

A = [];
B = [];
fdata = [];
bands = [1 4 ; 4 8 ; 8 13 ; 13 30 ; 30 45];

for i = 1:5
    [A(i, :), B(i, :)] = butter(3, bands(i, :)/(Fs/2));    % Normalization of frequencies, bandpass filter (order 3), coeffs
    fdata(:, :, i) = filtfilt(A(i, :), B(i, :),data')';     
end

sensor = 4; 

% Plot

figure(1);
subplot(2,3,1); plot(data(sensor,1:10*Fs)); title("EEG");
subplot(2,3,2); plot(fdata(sensor,1:10*Fs, 1)); title("Delta");
subplot(2,3,3); plot(fdata(sensor,1:10*Fs, 2)); title("Theta");
subplot(2,3,4); plot(fdata(sensor,1:10*Fs, 3)); title("Alpha");
subplot(2,3,5); plot(fdata(sensor,1:10*Fs, 4)); title("Beta");
subplot(2,3,6); plot(fdata(sensor,1:10*Fs, 5)); title("Gamma");

% EEG bands as a dynamical trajectory 

[XX, eLAG, eDIM] = phaseSpaceReconstruction(data(sensor,1:10*Fs));
[XX1, eLAG1, eDIM1] = phaseSpaceReconstruction(fdata(sensor,1:10*Fs, 1));
[XX2, eLAG2, eDIM2] = phaseSpaceReconstruction(fdata(sensor,1:10*Fs, 2));
[XX3, eLAG3, eDIM3] = phaseSpaceReconstruction(fdata(sensor,1:10*Fs, 3));
[XX4, eLAG4, eDIM4] = phaseSpaceReconstruction(fdata(sensor,1:10*Fs, 4));
[XX5, eLAG5, eDIM5] = phaseSpaceReconstruction(fdata(sensor,1:10*Fs, 5));

% A smaller approximateEntropy means more predictable the signal

aE1 = approximateEntropy((fdata(sensor,1:10*Fs, 1)),eLAG1,eDIM1)
aE2 = approximateEntropy((fdata(sensor,1:10*Fs, 2)),eLAG2,eDIM2)
aE3 = approximateEntropy((fdata(sensor,1:10*Fs, 3)),eLAG3,eDIM3)
aE4 = approximateEntropy((fdata(sensor,1:10*Fs, 4)),eLAG4,eDIM4)
aE5 = approximateEntropy((fdata(sensor,1:10*Fs, 5)),eLAG5,eDIM5)

% A smaller correlationDimension means smaller level of chaotic complexity

cDim1 = correlationDimension((fdata(sensor,1:10*Fs, 1)),eLAG1,eDIM1)
cDim2 = correlationDimension((fdata(sensor,1:10*Fs, 2)),eLAG2,eDIM2)
cDim3 = correlationDimension((fdata(sensor,1:10*Fs, 3)),eLAG3,eDIM3)
cDim4 = correlationDimension((fdata(sensor,1:10*Fs, 4)),eLAG4,eDIM4)
cDim5 = correlationDimension((fdata(sensor,1:10*Fs, 5)),eLAG5,eDIM5)

% Plot

figure(2);
subplot(2,3,1);plot3(XX(1:1000,1),XX(1:1000,2),XX(1:1000,3));grid; title("EEG");
subplot(2,3,2);plot3(XX1(1:1000,1),XX1(1:1000,2),XX1(1:1000,3));grid; title("Delta"); 
subplot(2,3,3);plot3(XX2(1:1000,1),XX2(1:1000,2),XX2(1:1000,3));grid; title("Theta");
subplot(2,3,4);plot3(XX3(1:1000,1),XX3(1:1000,2),XX3(1:1000,3));grid; title("Alpha");
subplot(2,3,5);plot3(XX4(1:1000,1),XX4(1:1000,2),XX4(1:1000,3));grid; title("Beta");
subplot(2,3,6);plot3(XX5(1:1000,1),XX5(1:1000,2),XX5(1:1000,3));grid; title("Gamma");


%% Provide a NonLinear Dynamics description as a function of sensor. 
clear;
load EEG_data.mat

k = 1;

for i = 1:10
    figure(i)
    for j = 1 : 2
        if i == 1 && j == 1
            [XX, eLAG, eDIM] = phaseSpaceReconstruction(data(2, 1:10*Fs));
            subplot(1,2,j); plot3(XX(1:1000,1),XX(1:1000,2),XX(1:1000,3)); grid; title("EEG");
        else
            [XX, eLAG, eDIM] = phaseSpaceReconstruction(data(i, 1:10 * Fs));
            subplot(1,2,j); plot3(XX(1:1000,1),XX(1:1000,2),XX(1:1000,3)); grid; title("Sensor" + " " + num2str(k));
            aE = approximateEntropy((data(k,1:10*Fs)),eLAG,eDIM)
            cDim = correlationDimension((data(k,1:10*Fs)),eLAG,eDIM)
            k = k + 1;
        end
    end
end




