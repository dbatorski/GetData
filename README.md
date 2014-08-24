GetData
=======

Repository for Getting and Cleaning Data Course Project.

## Files in the repository

* run_analysis.R conains script for downloading unzipping and processing the Samsung data, it: 
     + Loads the data
     + Merges the training and the test sets to create one data set.
     + Extracts only the measurements on the mean and standard deviation for each measurement.
     + Uses descriptive activity names to name the activities in the data set
     + Appropriately labels the data set with descriptive activity names.
     + Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* CodeBook.md describes the variables, the data, and transformations performed to clean up the data.

## Output datasets

run_analysis.R produces two resulting datasets: 

1. merged_data.txt a merged dataset with selected variables
2. merged_data_avg.txt contains one row for each pair of subject and activity. In columns there are: subject, activity, and average value for each feature (i.e. a mean or standard deviation from the original dataset).

## The Data

Data used in this analysis came from: 
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

For more information about this dataset contact: activityrecognition@smartlab.ws
