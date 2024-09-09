% Extract features and target from the dataset
X = dataTable{:, 1:6};  % Input features (6 columns)
Y = dataTable.BandwidthAllocated_Mbps;  % Target variable

% Split data into training and testing sets
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


% Convert to a cell array for sequential data (LSTM requires this format)
XTrain = num2cell(XTrain, 2);
XTest = num2cell(XTest, 2);

% Train the exported network
options = trainingOptions('adam', ...
    'MaxEpochs', 100, ...
    'MiniBatchSize', 64, ...
    'InitialLearnRate', 0.001, ...
    'Plots', 'training-progress');

% Assuming the exported network is saved as 'net'
net = trainNetwork(XTrain, YTrain, exportedNetwork, options);

% Test the network
YPred = predict(net, XTest);

% Calculate performance metrics (e.g., MSE)
mseError = mse(YPred, YTest);
disp(['Test MSE: ', num2str(mseError)]);
