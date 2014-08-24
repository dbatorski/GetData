Code book
=======

This code book describes the data, the variables, and transformations performed to clean up the data. 


## Original Data

Data used in this analysis came from: 
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

For more information about this dataset contact: activityrecognition@smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


## Selected variables

The features selected for original database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

From these signals a set of variables were estimated. For the final dataset ony two of them were selected:  
mean(): Mean value  
std(): Standard deviation  

The complete list of variables of each feature vector in original dataset is available in 'features.txt'


## Transformations 

First training and test data are merged and variable names are added using features.txt file. 


```r
# Merge the training and the test sets to create one data set.
features <- read.table("features.txt")

train_data <- read.table("train/X_train.txt")
test_data <- read.table("test/X_test.txt")
X_all <- rbind(train_data, test_data)
names(X_all) <- gsub(",|\\(|\\)","",features[,2])

subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
subject_all <- rbind(subject_train, subject_test)

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
activity_all <- rbind(y_train, y_test)
```

Only columns with variables conaining names with "-mean()" or "-std()" are selected.


```r
# Extracts only the measurements on the mean and standard deviation for each measurement. 
selected_variables <- grep("-mean\\(\\)|-std\\(\\)",features[,2])
X_all <- X_all[,selected_variables]
```

Activity variable is created by substituting values with activity names in a loop.


```r
# Uses descriptive activity names to name the activities in the data set
names(activity_all) <- "activity"
activity <- read.table("activity_labels.txt")

y <- activity_all$activity
for(i in 1:6){
     y <- replace(y, y==i, as.character(activity[i,2]) )
}
activity_all$activity <- y
```

Most of the variables were labeled earlier, here the subject variable recives its name. 


```r
# Appropriately labels the data set with descriptive variable names. 
names(subject_all) <- "subject"
```

Data are merged with subject and activity variables. The data are saved.


```r
data1 <- cbind(subject_all, activity_all, X_all)
write.table(data1, "merged_data.txt", row.names=FALSE)
```

The final dataset is produces using aggregate function. 


```r
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy <- aggregate(data1[3:dim(data1)[2]], by=list(data1[,1],data1[,2]), FUN=mean, simplify = TRUE)
names(tidy)[1:2] <- names(data1[1:2])
write.table(tidy, "merged_data_avg.txt", row.names=FALSE)
```
