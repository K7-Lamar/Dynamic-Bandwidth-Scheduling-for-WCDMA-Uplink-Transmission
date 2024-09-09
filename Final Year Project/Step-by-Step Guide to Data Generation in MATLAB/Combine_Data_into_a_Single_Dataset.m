% Combine all features into a matrix
data = [trafficDemand, SNR, CQI, QoS_latency, userSpeed, interference];

% Convert to table for easier visualization and manipulation
dataTable = array2table(data, 'VariableNames', ...
    {'TrafficDemand_Mbps', 'SNR_dB', 'CQI', 'QoS_Latency_ms', 'UserSpeed_kmh', 'Interference_dBm'});

% Add the target (bandwidth allocation)
dataTable.BandwidthAllocated_Mbps = bandwidth;

% Display first few rows of the dataset
head(dataTable)
