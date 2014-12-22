### Introduction
This project uses data collected from the Samsung Galaxy S smartphone accelerometers and gyroscopes available from [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). It prepares data for human activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) recognition modeling based on mean and standard deviation of the measurements collected via accelerometers and gyroscopes.

### Original dataset
The Human Activity Recognition Using Smartphones Data Set has been partitioned into train and test sets containing measurements collected from 70% and 30% of the volunteers respectively.

The data sets are distributed in 6 files:

1. `X_train.txt` and `X_test.txt` containing feature vectors (`X`) - preprossesed measurements collected from accelerometers and gyroscopes of volunteers performing specified activities.
2. `y_train.txt` and `y_test.txt` containing class labels (`y`) - activities performed by the subjects during the measurements.
3. `subject_train.txt` and `subject_test.txt` containing information on the subjects performing activities.

### run_analysis.R file
The run_analysis.R script downloads the original Human Activity Recognition Using Smartphones data set and performs on it the following transformations:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Applies descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. Prepares a second, independent tidy data set with the average of each variable for each activity and each subject.

The above described functionality is provided via a set of functions (described in the order of their definition and usage):

1. `prepareFiles` - downloads and extracts the Human Activity Recognition Using Smartphones data set in the working directory (if needed).
2. `readMergeData` - reads the features, class labels, and subjects files for train and test data sets; merges the train and test data sets keeping the original files structure (separate files for features, class labels, and subjects); it returns a 3-elements list - for features, class labels, and subjects data - containing 10299 observations each.
3. `extractMeanSdData` - extracts mean and standard deviation measurements; it reduces the number of features from 561 to 66.
4. `nameActivities` - replaces class labels codes with their names.
5. `bindData` - binds features, class labels, and subjects data together to create 1 dataset containing 10299 observations across 68 variables (33 for mean measurements, 33 for standard deviation measuremens, 1 for activity label, and 1 for subject identifier);
6. `cleanData()` - the main function combining all the previously described functions to create tidy dataset; it returns the dataset as described in points 1-4; it also creates and saves in the working directory the dataset described in point 5. 

The script requires `plyr` package to be installed.

#### Running run_analysis.R script

To create the tidy datasets set the working directory of your choice and type the following commands:

`source(run_analysis.R)`

`tidyDataset <- cleanData()`

It will assign dataset described in points 1-4 of the previous section to the variable `tidyDataset` and create the file `Ex5_Dataset.txt` containing the data set from point 5 in your working directory.