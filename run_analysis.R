# ========================================================================================================== #
#                                                PREPARING FILES                                             #
# ========================================================================================================== #

setwd("D:/LEARNING/COURSES/COURSERA_SPECIALIZATIONS/Data Science/Datasets")

prepareFiles <- function() {
  if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    message("Downloading data set...")
    download.file(fileURL, "getdata-projectfiles-UCI HAR Dataset.zip")
    downloadDate <- date()
  }
  
  if (!file.exists("UCI HAR Dataset")) {
    message("Extracting data...")
    unzip("getdata-projectfiles-UCI HAR Dataset.zip")
    message("Data extraction finished.")
  }
  
  message("Everything's ready for analysis.")
}


# ========================================================================================================== #
#                                             READING & MERGING DATA                                         #
# ========================================================================================================== #

readMergeData <- function() {
  # loading annotations
  features <- read.table("UCI HAR Dataset/features.txt")
  colnames(features) <- c("featureID", "feature")
  
  # loading training data
  message("Loading training data...")
  X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
  colnames(X_train) <- features$feature
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  colnames(y_train) <- c("activity")
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  colnames(subject_train) <- c("subject")
  message("Loading training data finished.")
  
  # loading test data
  message("Loading test data...")
  X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
  colnames(X_test) <- features$feature
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
  colnames(y_test) <- c("activity")
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  colnames(subject_test) <- c("subject")
  message("Loading test data finished.")
  
  # merging train and test data sets
  mergedX <- rbind(X_train, X_test)
  mergedY <- rbind(y_train, y_test)
  mergedSubject <- rbind(subject_train, subject_test)
  
  list(x = mergedX, y = mergedY, subject = mergedSubject)
}


# ========================================================================================================== #
#                                      EXTRACT MEAN AND STD MEASUREMENTS                                     #
# ========================================================================================================== #

extractMeanSdData <- function(dx) {
  cn <- colnames(dx)
  meanCols <- grepl("mean()", cn, fixed = TRUE)
  stdCols <- grepl("std()", cn, fixed = TRUE)
  
  dx[, (meanCols | stdCols)]
}


# ========================================================================================================== #
#                                           APPLY NAMES TO ACTIVITIES                                        #
# ========================================================================================================== #

nameActivities <- function(dy) {
  # loading annotations
  activities <- read.table("UCI HAR Dataset/activity_labels.txt")
  colnames(activities) <- c("actID", "activity")
  for (i in seq_along(dy$activity)) {
    dy[i, 1] <- as.character( activities[dy[i, 1], 2] )
  }
  dy
}


# ========================================================================================================== #
#                               BIND FEATURES, CLASS LABELS & SUBJECTS DATA                                  #
# ========================================================================================================== #

bindData <- function(dx, dy, subject) {
  cbind(dx, dy, subject)
}


# ========================================================================================================== #
#                                         CREATE AVERAGES DATASET (EX. 5)                                    #
# ========================================================================================================== #

createAveragesDataset <- function(ds) {
  library(plyr)
  d <- ddply(ds, .(subject, activity), function(x) colMeans(x[, 1:60]))
  d
}


# ========================================================================================================== #
#                                     MAIN FUNCTION CREATING TIDY DATASET                                    #
# ========================================================================================================== #

cleanData <- function() {
  # preparing files to analysis
  setwd("D:/LEARNING/COURSES/COURSERA_SPECIALIZATIONS/Data Science/Datasets")
  prepareFiles()
  # creating tidy dataset as described in points 1-4
  mergedData <- readMergeData()
  dx <- extractMeanSdData(mergedData$x) 
  dy <- nameActivities(mergedData$y)
  dataset <- bindData(dx, dy, mergedData$subject)
  # creating the averages dataset (ex. 5)
  averagesDataset <- createAveragesDataset(dataset)
  # saving averages dataset = returning tidy dataset as described in point 5
  write.table(averagesDataset, file = "Ex5_Dataset.txt", row.name = FALSE)
  # returning tidy dataset as described in points 1-4
  dataset
}