% Simulate user speed in km/h (range 0 to 120 km/h)
userSpeed = 30 + 40 * randn(numSamples, 1);  % Mean = 30 km/h, std = 40 km/h
userSpeed = max(userSpeed, 0);  % No negative values
