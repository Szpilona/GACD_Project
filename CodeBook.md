### Introduction

### run_analysis.R file
The run_analysis.R script downloads the original Human Activity Recognition Using Smartphones data set and performs on it the following transformations:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Applies descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. Prepares a second, independent tidy data set with the average of each variable for each activity and each subject.

The above described functionality is provided via a set of functions:

1. `prepareFiles` - downloads and extracts the data set in the working directory (if needed).
2. `readMergeData` - reads the features, class labels, and subjects files for train and test data sets; merges the train and test data sets keeping the original files structure (separate files for features, class labels, and subjects).
3. `extractMeanSdData` - extracts mean and standard deviation measurements.
4. `nameActivities` - replaces class labels codes with their names.
5. `bindData` - binds features, class labels, and subjects data together to create 1 dataset;
6. `cleanData()` - the main function combining all the previously described functions to create tidy dataset; it returns the dataset as described in points 1-4; it also creates and saves in the working directory the dataset described in point 5. 