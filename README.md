# Getting and Cleaning Data Project 1 

CodeBook.md will explain step by step how the run_analysis.r script works and gives a list of variables created. 

**How to use run_analysis.r**

1. First you must get the zip file that contains all the data from the Samsung Galaxy study. That can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. Unzip the contents into a directory and save the run_analysis.r script in that same directory. Set your working directory so you can access these files. 

3. Use source("run_analysis.R") which will produce MeasurementMeans.txt (282 KB) and ActivityMeasurements.txt (10.1 MB) in your working directory. MeasurentMeans.txt is the final product of the script and holds the mean of each measurement as determined by Subject and their Activity. 

