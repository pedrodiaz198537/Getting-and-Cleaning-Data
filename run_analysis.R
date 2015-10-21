# Set working directory
dir <- c("C:/Users/pdiaz018/Documents/Coursera/Data Science/R/Getting and Cleaning Data/Course Project/UCI HAR Dataset")
setwd(dir)
# Read in columm names for test/training data
features <- readLines("./features.txt")
# Read in row identifiers for test data
dir <- c("C:/Users/pdiaz018/Documents/Coursera/Data Science/R/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test")
setwd(dir)
test_row <- readLines("./subject_test.txt")
# Read in Activity identifier
test_activity <- readLines("./y_test.txt")
# Read in test data
dir <- c("C:/Users/pdiaz018/Documents/Coursera/Data Science/R/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test")
setwd(dir)
test <- read.table("./X_test.txt",
                   col.names = features)
# Add activity labels to test data
test <- cbind("Activity" = test_activity, test)
# Add row identifiers to test data
test <- cbind("Subject_ID" = test_row, test)
# Read in row identifiers for training data
dir <- c("C:/Users/pdiaz018/Documents/Coursera/Data Science/R/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train")
setwd(dir)
train_row <- readLines("./subject_train.txt")
# Read in Activity identifier
train_activity <- readLines("./y_train.txt")
# Read in in training data
train <- read.table("./X_train.txt", 
                   col.names = features)
# Add activity labels to test data
train <- cbind("Activity" = train_activity, train)
# Add row identifiers to train data
train <- cbind("Subject_ID" = train_row, train)
# Merge test and train datasets
library(plyr)
test_train <- join(test, train, type = "full")
# Coerce row identifiers from factor to numeric to prepare it for sorting
test_train$Subject_ID <- as.numeric(test_train$Subject_ID)
# Sort row identifier "Subject_ID"
test_train <- test_train[order(test_train$Subject_ID),]
# Create a lookup table for mean columns in the dataset
mean_index <- agrep("mean", features)+2
# Create a lookup table for std columns in the dataset
std_index <- agrep("std", features)+2
# Create lookup table for mean, std, and Subject_ID
lookup_table <- c(1:2, mean_index, std_index)
lookup_table <- sort(lookup_table)
# Extract only the measurements on the mean and std for each measurement. 
test_train_mean_std <- test_train[, lookup_table]
# Read in Activity Labels
dir <- c("C:/Users/pdiaz018/Documents/Coursera/Data Science/R/Getting and Cleaning Data/Course Project/UCI HAR Dataset")
setwd(dir)
activity_labels <- readLines("./activity_labels.txt")
test_train_mean_std$Activity <- as.numeric(test_train_mean_std$Activity)
# Rename activity numbers to corresponding descriptive activity name.
test_train_mean_std$Activity <- sub(1, activity_labels[1], test_train_mean_std$Activity)
test_train_mean_std$Activity <- sub(2, activity_labels[2], test_train_mean_std$Activity)
test_train_mean_std$Activity <- sub(3, activity_labels[3], test_train_mean_std$Activity)
test_train_mean_std$Activity <- sub(4, activity_labels[4], test_train_mean_std$Activity)
test_train_mean_std$Activity <- sub(5, activity_labels[5], test_train_mean_std$Activity)
test_train_mean_std$Activity <- sub(6, activity_labels[6], test_train_mean_std$Activity)
# Create second, independent tidy data set with the average of each variable for each 
# activity and each subject.

# Create new empty data frame with column names and empty rows
new_df <- test_train_mean_std[1:88]
new_df<- new_df[-c(1:10299), ]
# Create empty data frame to subset by activity and subject ID
Activity_Subset <- data.frame()
Subject_Subset <- data.frame()
final_DF <- data.frame()
for (i in 1:length(activity_labels)) {
  Activity_Subset <- test_train_mean_std[which(test_train_mean_std$Activity ==
                                                     activity_labels[i]), ]
  
  for (j in 1:30) {
    Subject_Subset <- Activity_Subset[which(Activity_Subset$Subject_ID ==
                                              j), ]
    colmean <- colMeans(Subject_Subset[,3:88])
    new_df[1, ] <- c(j, activity_labels[i], colmean)
    final_DF <- rbind(final_DF, new_df)
  }
}