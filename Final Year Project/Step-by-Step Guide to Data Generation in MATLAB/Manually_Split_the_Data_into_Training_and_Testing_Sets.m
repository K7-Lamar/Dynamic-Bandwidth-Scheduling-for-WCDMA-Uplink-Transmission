% Set the ratio for training (80% for training, 20% for testing)
trainRatio = 0.8;

% Find the number of training samples
numTrain = floor(trainRatio * size(X, 1));

% Randomly shuffle the data (optional but recommended for better training)
randIndices = randperm(size(X, 1));

% Split into training and testing sets
XTrain = X(randIndices(1:numTrain), :);  % First 80% for training
YTrain = Y(randIndices(1:numTrain));     % Corresponding labels

XTest = X(randIndices(numTrain+1:end), :);  % Last 20% for testing
YTest = Y(randIndices(numTrain+1:end));     % Corresponding labels
