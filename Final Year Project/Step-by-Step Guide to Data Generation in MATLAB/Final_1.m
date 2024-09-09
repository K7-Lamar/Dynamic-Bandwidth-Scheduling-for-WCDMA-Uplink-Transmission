% Step 1: Load the CSV file into a variable
dataTable = readtable('bandwidth_scheduling_data.csv');

% Step 2: Extract the input features (first 6 columns) and target variable (7th column)
X = dataTable{:, 1:6};  % Input features (6 columns)
Y = dataTable.BandwidthAllocated_Mbps;  % Target variable

% Step 3: Split the Data into Training and Testing Sets
trainRatio = 0.8;
numTrain = floor(trainRatio * size(X, 1));
randIndices = randperm(size(X, 1));

XTrain = X(randIndices(1:numTrain), :);
YTrain = Y(randIndices(1:numTrain));
XTest = X(randIndices(numTrain+1:end), :);
YTest = Y(randIndices(numTrain+1:end));

% Step 4: Define the Network Layers
layers = [
    featureInputLayer(6, 'Name', 'input')        % Input layer for 6 features
    fullyConnectedLayer(64, 'Name', 'fc1')       % Fully connected layer with 64 neurons
    reluLayer('Name', 'relu1')                   % ReLU activation
    fullyConnectedLayer(32, 'Name', 'fc2')       % Fully connected layer with 32 neurons
    reluLayer('Name', 'relu2')                   % ReLU activation
    fullyConnectedLayer(1, 'Name', 'output')     % Output layer for regression
    regressionLayer('Name', 'regression')];      % Regression output layer

% Step 5: Define the Training Options
options = trainingOptions('adam', ...
    'MaxEpochs', 100, ...
    'MiniBatchSize', 64, ...
    'InitialLearnRate', 0.001, ...
    'Plots', 'training-progress', ...
    'Shuffle', 'every-epoch', ...
    'ValidationData', {XTest, YTest}, ...
    'ValidationFrequency', 10, ...
    'Verbose', false);

% Step 6: Train the Network
net = trainNetwork(XTrain, YTrain, layers, options);

% Step 7: Evaluate the Network
YPred = predict(net, XTest);
mseError = mse(YPred, YTest);
disp(['Test MSE: ', num2str(mseError)]);

% Step 8: Plot Results
figure;
plot(YTest, 'b');
hold on;
plot(YPred, 'r--');
legend('Actual', 'Predicted');
xlabel('Sample');
ylabel('Bandwidth Allocated (Mbps)');
title('Actual vs Predicted Bandwidth Allocations');
