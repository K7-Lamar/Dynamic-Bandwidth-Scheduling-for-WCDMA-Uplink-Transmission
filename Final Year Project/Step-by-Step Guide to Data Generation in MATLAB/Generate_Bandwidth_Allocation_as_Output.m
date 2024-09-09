% Simulate bandwidth allocation based on traffic demand, SNR, and QoS latency
bandwidth = trafficDemand .* (SNR / 15) .* (100 ./ QoS_latency);  % An arbitrary relationship
bandwidth = min(max(bandwidth, 0.5), 5);  % Clip between 0.5 Mbps and 5 Mbps
