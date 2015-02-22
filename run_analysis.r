## You will be required to submit: 
## 1) a tidy data set as described below, 
## 2) a link to a Github repository with your script for performing the analysis, and 
## 3) a code book that describes the variables, the data, and any transformations or 
## work that you performed to clean up the data called CodeBook.md. 
## You should also include a README.md in the repo with your scripts. 
## This repo explains how all of the scripts work and how they are connected.

## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.


## Extracting from zip file
## downloaded zip file from Coursera page and now unzip and save in project directory
setwd("/Users/nathansmith/Downloads/")
## check out the files in the zip folder before unzipping them
unzip("getdata_projectfiles_UCI HAR Dataset.zip", list = TRUE)
## export to project directory
unzip("getdata_projectfiles_UCI HAR Dataset.zip", exdir = "/Users/nathansmith/GetCleanData1/")
setwd("/Users/nathansmith/GetCleanData1/")
list.files(getwd())

## 1. Merges the training and the test sets to create one data set.
## read in training and test set
## read in test set
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_set <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
table(test_subject)
table(test_labels)

train_subject <-read.table("UCI HAR Dataset/train/subject_train.txt")
train_set <- read.table("UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
table(train_subject)
table(train_labels)

## merging test and train measurement sets with test set on top
measurejoin <- rbind(test_set, train_set)
labeljoin <- rbind(test_labels, train_labels)
subjectjoin <- rbind(test_subject, train_subject)

dim(measurejoin)
dim(labeljoin)
dim(subjectjoin)
## making sure all datapoints are accounted for 
## 7352+2947

JOINED <- cbind(subjectjoin, labeljoin, measurejoin)
dim(JOINED)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

mFeatures <- read.table("UCI HAR Dataset/features.txt")
dim(mFeatures)

## Find names of measurement means
mMeansName <- grep("mean", mFeatures[,2], ignore.case=TRUE, value = TRUE)
head(mMeansName)
## Find index of measurement means
mMeansIndex <- grep("mean", mFeatures[,2], ignore.case=TRUE)
length(mMeansIndex)
mMeansIndex

## Find names of measurement stdev
mStdName <- grep("std", mFeatures[,2], ignore.case=TRUE, value = TRUE)
head(mStdName)
## Find index of measurement stdev
mStdIndex <- grep("std", mFeatures[,2], ignore.case=TRUE)
mStdIndex

## making subset of measurejoin to only mean and standard deviations measurements
mMeanStd <- measurejoin[,c(mMeansIndex, mStdIndex)]
names(mMeanStd) <- c(mMeansName,mStdName) 
head(mMeanStd)

## Joining mean and standard deviation measurements to subject and activity labels
MeanStDevSet <- cbind(subjectjoin, labeljoin, mMeanStd)
## naming Subject and Activity columns
colnames(MeanStDevSet)[1:2] <- c("Subject", "Activity")
dim(MeanStDevSet)
head(MeanStDevSet)


## 3. Uses descriptive activity names to name the activities in the data set

activitynames <- read.table("/UCI HAR Dataset/activity_labels.txt")
## match each activity number with the name and replace Activity numbers with names in final dataset
MeanStDevSet[,2] <- activitynames[labeljoin[,1],2]
head(MeanStDevSet)
tail(MeanStDevSet)


## 4. Appropriately labels the data set with descriptive variable names. 

## already done in code above but for proof
head(MeanStDevSet)
write.table(MeanStDevSet, "ActivityMeasurements.txt", quote = FALSE, col.names=TRUE)


## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject.

library(plyr)
final <- MeanStDevSet
## hierarchy goes Subject, Activity, Measures

head(final)
cols <- length(names(final))
meanMeas <- ddply(final, .(Subject, Activity), function(x) colMeans(x[,3:cols]))
head(meanMeas)
write.table(meanMeas, "MeasurementMeans.txt", quote = FALSE, col.names = TRUE, row.names = FALSE)

