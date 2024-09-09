% Simulate traffic demand in Mbps
numSamples = 1000;  % Number of data points (time steps)
trafficDemand = 2 + 0.5 * randn(numSamples, 1);  % Mean = 2 Mbps, std = 0.5
trafficDemand = max(trafficDemand, 0);  % No negative values
