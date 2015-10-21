# Getting-and-Cleaning-Data
Repo for course project for the Coursera Getting and Cleaning Tidy Data class.

The script works by conducting the following steps:
1. Set working directory
2. Read in columm names for test/training data
3. Read in row identifiers for test data
4. Read in Activity identifier
5. Read in test data
6. Add activity labels to test data
7. Add row identifiers to test data
8. Read in row identifiers for training data
9. Read in Activity identifier
10. Read in in training data
11. Add activity labels to test data
12. Add row identifiers to train data
13. Merge test and train datasets
14. Coerce row identifiers from factor to numeric to prepare it for sorting
15. Sort row identifier "Subject_ID"
16. Create a lookup table for mean columns in the dataset
17. Create a lookup table for std columns in the dataset
18. Create lookup table for mean, std, and Subject_ID
19. Extract only the measurements on the mean and std for each measurement. 
20. Read in Activity Labels
21. Rename activity numbers to corresponding descriptive activity name.
22 Create second, independent tidy data set with the average of each variable for each activity and each subject.
22.a Create new empty data frame with column names and empty rows
22.b Create empty data frame to subset by activity and subject ID
