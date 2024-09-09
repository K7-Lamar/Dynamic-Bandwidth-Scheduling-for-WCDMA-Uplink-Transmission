% Simulate interference power level in dBm (range -110 to -70 dBm)
interference = -90 + 10 * randn(numSamples, 1);  % Mean = -90 dBm, std = 10 dBm
interference = min(max(interference, -110), -70);  % Clip between -110 and -70 dBm
