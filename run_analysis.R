#### PA GetData


# download data from the website if they haven't been already downloaded and unziped
if(!file.exists("UCI HAR Dataset")){
     fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
     download.file(fileUrl, destfile="getdataDataset.zip", method="curl")
     unzip("getdataDataset.zip")
}
setwd("./UCI HAR Dataset")


##############################################################################
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


##############################################################################
# Extracts only the measurements on the mean and standard deviation for each measurement. 

selected_variables <- grep("-mean\\(\\)|-std\\(\\)",features[,2])
X_all <- X_all[,selected_variables]


##############################################################################
# Uses descriptive activity names to name the activities in the data set
names(activity_all) <- "activity"
activity <- read.table("activity_labels.txt")

y <- activity_all$activity
for(i in 1:6){
     y <- replace(y, y==i, as.character(activity[i,2]) )
}
activity_all$activity <- y

##############################################################################
# Appropriately labels the data set with descriptive variable names. 

names(subject_all) <- "subject"

data1 <- cbind(subject_all, activity_all, X_all)
write.table(data1, "merged_data.txt", row.names=FALSE)


##############################################################################
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

tidy <- aggregate(data1[3:dim(data1)[2]], by=list(data1[,1],data1[,2]), FUN=mean, simplify = TRUE)
names(tidy)[1:2] <- names(data1[1:2])
write.table(tidy, "merged_data_avg.txt", row.names=FALSE)
