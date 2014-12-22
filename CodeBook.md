### Introduction

### run_analysis.R file
The run_analysis.R script downloads the original Human Activity Recognition Using Smartphones data set and performs on it the following transformations:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Applies descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. Prepares a second, independent tidy data set with the average of each variable for each activity and each subject.

The above described functionality is provided via a set of functions:

The function `cleanData()` returns the dataset as described in points 1-4. It also creates and saves in the current working directory the dataset described in point 5. 