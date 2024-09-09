% Step 1: Load the CSV file into a variable
% Load the dataset (adjust the path to your CSV file)
dataTable = readtable('bandwidth_scheduling_data.csv');

%Step 2: Proceed with the feature extraction
% Extract the input features (first 6 columns) and target variable (7th column)
X = dataTable{:, 1:6};  % Input features (6 columns)
Y = dataTable.BandwidthAllocated_Mbps;  % Target variable

%1. Manually Split the Data into Training and Testing Sets:
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

% 1. Define the Training Options:
% Specify training options (customize based on your requirements)
options = trainingOptions('adam', ...  % Adam optimizer
    'MaxEpochs', 100, ...              % Maximum number of epochs
    'MiniBatchSize', 64, ...           % Batch size
    'InitialLearnRate', 0.001, ...     % Learning rate
    'Plots', 'training-progress', ...  % Show training progress
    'Shuffle', 'every-epoch', ...      % Shuffle data every epoch
    'ValidationData', {XTest, YTest}, ...  % Validation data
    'ValidationFrequency', 10, ...     % Frequency of validation
    'Verbose', false);                 % Suppress detailed output

% 2. Train the Network:
% Train the network
net = trainNetwork(XTrain, YTrain, layers, options);

% 3. Evaluate the Network:
% Predict the bandwidth allocations on the test data
YPred = predict(net, XTest);

% Evaluate performance using Mean Squared Error (MSE)
mseError = mse(YPred, YTest);
disp(['Test MSE: ', num2str(mseError)]);

% 4. Plot Results:
% Plot actual vs predicted bandwidth allocations
figure;
plot(YTest, 'b');  % Actual values in blue
hold on;
plot(YPred, 'r--');  % Predicted values in red dashed line
legend('Actual', 'Predicted');
xlabel('Sample');
ylabel('Bandwidth Allocated (Mbps)');
title('Actual vs Predicted Bandwidth Allocations');
