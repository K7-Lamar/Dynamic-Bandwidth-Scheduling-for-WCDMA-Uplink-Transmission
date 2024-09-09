% Simulate QoS latency requirement in ms (range 20 to 100 ms)
QoS_latency = 50 + 20 * randn(numSamples, 1);  % Mean = 50 ms, std = 20 ms
QoS_latency = min(max(QoS_latency, 20), 100);  % Clip between 20 and 100 ms
