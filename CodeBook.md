
# Intro
This is a code book to describe the variables, the data, and any transformations I did to prepare the final data set. 

First of all, the original dataset can be found here: 
(This is a link to a zip file that will begin downloading after a prompt) 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

And a full description of the project can be found here: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


The script used to tidy the dataset and produce the various metrics we were interested in is called 
'run_analysis.R' and can be found in this repo. The script performs a number of functions, but first be sure to save the unzipped contents in your working directory so the code may access them. 

## Steps in run_analysis.r

1. First step is to merge the training and test sets, so the code will read in the files contained in the train and test directories and perform the 'rbind' operation to combine the two sets. 
The final product of this will be a data.frame named 'JOINED'.

2. Secondly, we want to collect only the measurements of the mean and standard deviations from each measure. So we will read in the 'features.txt' file and use the 'grep' function to find the variables where "mean" and "std" appear and put those into variable that contains the names and one that contains the column index where those names can be found. Then we use that index to make a subset of 'measurejoin' to only mean and standard deviations measurements.

3. We need to take the Activity labels which are originally just numbers 1-6 and use the 'activity_labels.txt' file to translate those into activity names. 

4. We confirm that our new data set of Subject, Activity, and list of measurement means and stdevs are are labeled with their correct headers and print that output to a file named 'ActivityMeasurements.txt' in our working directory.  

5. Finally, we find use the 'plyr' package and the 'ddply' function to find the col means of our measurements by Subject and Activity and print that output to a file names 'MeasurementMeans.txt' in our working directory. 


### Variables

From Step 1: 
Test and Training data are contained in: 'test_subject', 'test_set', 'test_labels', 'train_subject', 'train_set', 'train_labels'. The subjects, activity, and measures are joined in 'subjectjoin', 'activityjoin', and 'measurejoin', respectively. 
The merged data.frame of all those variables is contained in 'JOINED'


From Step 2: 
'mFeatures' contains the features.txt dataset. 'mMeansName' and 'mMeansIndex' contain the names and index of the mean measurements, respectively. 'mStdName' and 'mStdIndex' are the same thing but for standard deviation measurements. The subset of 'measurejoin' is 'mMeanStd' and then we join the subject id and activities to the subset in 'MeanStDevSet'. 


From Step 3: 
Activitynames are read in from 'activity_labels.txt' and we replace the activity ID with the activity name in the second column of the 'MeanStDevSet' variable. 


From Step 4: 
No new variables created, as the 'MeanStDevSet' variable has already been giving appropriate header names. 

From Step 5:
We rename 'MeanStDevSet' as 'final' and the 'meanMeas' variable contains the means for each measurement according to Subject and Activity. 'meanMeas' is then printed to 'MeasurementMeans.txt'













