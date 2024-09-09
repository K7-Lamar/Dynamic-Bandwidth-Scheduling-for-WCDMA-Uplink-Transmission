% Save the dataset to a .mat file
save('bandwidth_scheduling_data.mat', 'dataTable');

% Or save it to a CSV file for easier inspection
writetable(dataTable, 'bandwidth_scheduling_data.csv');
