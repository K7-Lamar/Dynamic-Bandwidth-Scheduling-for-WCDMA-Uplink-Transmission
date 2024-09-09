% Simulate traffic demand in Mbps
numSamples = 1000;  % Number of data points (time steps)
trafficDemand = 2 + 0.5 * randn(numSamples, 1);  % Mean = 2 Mbps, std = 0.5
trafficDemand = max(trafficDemand, 0);  % No negative values


% Simulate SNR in dB (range 0 to 30 dB)
SNR = 15 + 5 * randn(numSamples, 1);  % Mean = 15 dB, std = 5 dB
SNR = min(max(SNR, 0), 30);  % Clip SNR between 0 and 30 dB


% Simulate CQI (range 1 to 15)
CQI = round(8 + 4 * randn(numSamples, 1));  % Mean = 8, std = 4
CQI = min(max(CQI, 1), 15);  % Clip CQI between 1 and 15


% Simulate QoS latency requirement in ms (range 20 to 100 ms)
QoS_latency = 50 + 20 * randn(numSamples, 1);  % Mean = 50 ms, std = 20 ms
QoS_latency = min(max(QoS_latency, 20), 100);  % Clip between 20 and 100 ms

% Simulate user speed in km/h (range 0 to 120 km/h)
userSpeed = 30 + 40 * randn(numSamples, 1);  % Mean = 30 km/h, std = 40 km/h
userSpeed = max(userSpeed, 0);  % No negative values


% Simulate interference power level in dBm (range -110 to -70 dBm)
interference = -90 + 10 * randn(numSamples, 1);  % Mean = -90 dBm, std = 10 dBm
interference = min(max(interference, -110), -70);  % Clip between -110 and -70 dBm


% Simulate bandwidth allocation based on traffic demand, SNR, and QoS latency
bandwidth = trafficDemand .* (SNR / 15) .* (100 ./ QoS_latency);  % An arbitrary relationship
bandwidth = min(max(bandwidth, 0.5), 5);  % Clip between 0.5 Mbps and 5 Mbps


% Combine all features into a matrix
data = [trafficDemand, SNR, CQI, QoS_latency, userSpeed, interference];

% Convert to table for easier visualization and manipulation
dataTable = array2table(data, 'VariableNames', ...
    {'TrafficDemand_Mbps', 'SNR_dB', 'CQI', 'QoS_Latency_ms', 'UserSpeed_kmh', 'Interference_dBm'});

% Add the target (bandwidth allocation)
dataTable.BandwidthAllocated_Mbps = bandwidth;

% Display first few rows of the dataset
head(dataTable)


% Save the dataset to a .mat file
save('bandwidth_scheduling_data.mat', 'dataTable');

% Or save it to a CSV file for easier inspection
writetable(dataTable, 'bandwidth_scheduling_data.csv');
