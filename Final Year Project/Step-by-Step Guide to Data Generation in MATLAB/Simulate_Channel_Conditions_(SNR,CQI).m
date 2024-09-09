% Simulate SNR in dB (range 0 to 30 dB)
SNR = 15 + 5 * randn(numSamples, 1);  % Mean = 15 dB, std = 5 dB
SNR = min(max(SNR, 0), 30);  % Clip SNR between 0 and 30 dB

% Simulate CQI (range 1 to 15)
CQI = round(8 + 4 * randn(numSamples, 1));  % Mean = 8, std = 4
CQI = min(max(CQI, 1), 15);  % Clip CQI between 1 and 15
